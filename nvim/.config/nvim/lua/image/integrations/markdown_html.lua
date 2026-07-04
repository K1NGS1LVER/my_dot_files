-- image.nvim's built-in "markdown" integration
-- (~/.local/share/nvim/lazy/image.nvim/lua/image/integrations/markdown.lua)
-- only queries the markdown_inline tree for native ![alt](url) syntax. It
-- never looks at the injected html tree, so raw <img> tags embedded in
-- markdown (a very common README pattern for centered/sized images, e.g.
-- <p align="center"><img src="..."></p>) are invisible to it on ANY
-- terminal, not just tmux. This is a separate integration that only
-- handles that case, registered alongside the built-in one.
local document = require("image/utils/document")

return document.create_document_integration({
  name = "markdown_html",
  debug = true,
  default_options = {
    clear_in_insert_mode = false,
    download_remote_images = true,
    only_render_image_at_cursor = false,
    filetypes = { "markdown", "vimwiki", "quarto" },
  },
  query_buffer_images = function(buffer)
    local buf = buffer or vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(buf, "markdown")
    parser:parse(true)
    local html_lang = "html"
    local html_tree = parser:children()[html_lang]
    if not html_tree then return {} end

    -- attribute-name/value text isn't known until the query matches, so this
    -- can't be a single anchored pattern (attribute order in the tag is
    -- arbitrary). Instead: find every <img> element, find every attribute,
    -- and correlate them by walking each attribute's ancestor chain.
    local tag_query = vim.treesitter.query.parse(html_lang, "(element (start_tag (tag_name) @tag) @element)")
    local attr_query = vim.treesitter.query.parse(
      html_lang,
      "(attribute (attribute_name) @attr_name (quoted_attribute_value (attribute_value) @attr_value))"
    )

    local images = {}
    local function get_html_images(tree)
      local root = tree:root()

      local img_elements = {}
      ---@diagnostic disable-next-line: missing-parameter
      for id, node in tag_query:iter_captures(root, buf) do
        if tag_query.captures[id] == "tag" and vim.treesitter.get_node_text(node, buf):lower() == "img" then
          -- node = tag_name; tag_name -> start_tag -> element (two hops up)
          local element_node = node:parent() and node:parent():parent()
          if element_node then img_elements[element_node:id()] = element_node end
        end
      end
      if vim.tbl_isempty(img_elements) then return end

      ---@diagnostic disable-next-line: missing-parameter
      for id, node in attr_query:iter_captures(root, buf) do
        if attr_query.captures[id] == "attr_name" and vim.treesitter.get_node_text(node, buf):lower() == "src" then
          -- node = attribute_name; attribute_name -> attribute -> start_tag -> element
          local start_tag = node:parent() and node:parent():parent()
          local element_node = start_tag and start_tag:parent()
          if element_node and img_elements[element_node:id()] then
            local value_node = node:next_named_sibling()
            local attr_value = value_node and value_node:named_child(0)
            if attr_value then
              local start_row, start_col, end_row, end_col = element_node:range()
              table.insert(images, {
                node = element_node,
                range = {
                  start_row = start_row,
                  start_col = start_col,
                  end_row = end_row,
                  end_col = end_col,
                },
                url = vim.treesitter.get_node_text(attr_value, buf),
              })
            end
          end
        end
      end
    end

    html_tree:for_each_tree(get_html_images)

    return images
  end,
})

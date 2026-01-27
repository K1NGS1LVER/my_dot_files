import os

# Configuration
ROOT_DIR = "."
EXCLUDE_DIRS = {".obsidian", ".git", ".gemini", ".trash", "node_modules", ".idea", ".vscode"}
EXCLUDE_FILES = {"auto_linker.py", "DS_Store"}
MASTER_INDEX_NAME = "000_Master_Index.md"

def get_moc_name(folder_name, is_root=False):
    if is_root:
        return MASTER_INDEX_NAME
    clean_name = "".join(c for c in folder_name if c.isalnum() or c in (' ', '_', '-')).strip()
    return f"{clean_name}_MOC.md"

def process_directory(current_path):
    abs_path = os.path.abspath(current_path)
    root_abs_path = os.path.abspath(ROOT_DIR)
    folder_name = os.path.basename(abs_path)
    is_root = (abs_path == root_abs_path)
    
    moc_filename = get_moc_name(folder_name, is_root)
    
    files_to_link = []
    subdirs_to_link = []

    try:
        entries = os.listdir(current_path)
    except OSError as e:
        print(f"Skipping {current_path}: {e}")
        return

    entries.sort()

    for entry in entries:
        full_path = os.path.join(current_path, entry)
        if entry in EXCLUDE_DIRS or entry in EXCLUDE_FILES or entry.startswith('.'):
            continue

        if os.path.isdir(full_path):
            process_directory(full_path)
            subdirs_to_link.append(entry)
        elif os.path.isfile(full_path):
            if entry.endswith(".md") and entry != moc_filename:
                files_to_link.append(entry)

    if not files_to_link and not subdirs_to_link:
        return

    content = []
    content.append("---")
    content.append(f"tags: [MOC]")
    content.append("---")
    content.append("")
    
    title = "Master Index" if is_root else folder_name
    content.append(f"# {title}")
    content.append("")
    
    if not is_root:
        parent_dir = os.path.dirname(abs_path)
        if parent_dir == root_abs_path:
            parent_moc_link = MASTER_INDEX_NAME.replace(".md", "")
        else:
            parent_name = os.path.basename(parent_dir)
            parent_moc_link = get_moc_name(parent_name, is_root=False).replace(".md", "")
        
        # Simple link for the "Up" navigation
        content.append(f"**Parent Context**: [[{parent_moc_link}|Up]]")
        content.append("")

    # --- Folders Section (Collapsible) ---
    if subdirs_to_link:
        content.append("> [!example]+ Directories")
        for subdir in subdirs_to_link:
            subdir_moc_name = get_moc_name(subdir).replace(".md", "")
            content.append(f"> - 📂 [[{subdir_moc_name}|{subdir}]]")
        content.append("")

    # --- Notes Section (Collapsible) ---
    if files_to_link:
        content.append("> [!info]+ Notes")
        for file in files_to_link:
            name_no_ext = os.path.splitext(file)[0]
            content.append(f"> - 📄 [[{name_no_ext}]]")

    moc_path = os.path.join(current_path, moc_filename)
    try:
        with open(moc_path, "w", encoding="utf-8") as f:
            f.write("\n".join(content))
        print(f"Updated: {moc_path}")
    except IOError as e:
        print(f"Error writing {moc_path}: {e}")

if __name__ == "__main__":
    process_directory(ROOT_DIR)

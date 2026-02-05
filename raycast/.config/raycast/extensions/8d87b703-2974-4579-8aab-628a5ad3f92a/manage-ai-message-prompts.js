"use strict";var L=Object.create;var k=Object.defineProperty;var N=Object.getOwnPropertyDescriptor;var W=Object.getOwnPropertyNames;var z=Object.getPrototypeOf,V=Object.prototype.hasOwnProperty;var j=(e,r)=>{for(var a in r)k(e,a,{get:r[a],enumerable:!0})},E=(e,r,a,l)=>{if(r&&typeof r=="object"||typeof r=="function")for(let s of W(r))!V.call(e,s)&&s!==a&&k(e,s,{get:()=>r[s],enumerable:!(l=N(r,s))||l.enumerable});return e};var F=(e,r,a)=>(a=e!=null?L(z(e)):{},E(r||!e||!e.__esModule?k(a,"default",{value:e,enumerable:!0}):a,e)),G=e=>E(k({},"__esModule",{value:!0}),e);var X={};j(X,{AiMessagePresetEditorForm:()=>w,default:()=>D});module.exports=G(X);var t=require("@raycast/api"),x=require("react");var h=F(require("react")),c=require("@raycast/api");var R=require("react/jsx-runtime");function v(e){let r=(0,h.useRef)(e);return r.current=e,r}function B(e,r){let a=this[e];return a instanceof Date?`__raycast_cached_date__${a.toISOString()}`:Buffer.isBuffer(a)?`__raycast_cached_buffer__${a.toString("base64")}`:r}function K(e,r){return typeof r=="string"&&r.startsWith("__raycast_cached_date__")?new Date(r.replace("__raycast_cached_date__","")):typeof r=="string"&&r.startsWith("__raycast_cached_buffer__")?Buffer.from(r.replace("__raycast_cached_buffer__",""),"base64"):r}var H=Symbol("cache without namespace"),_=new Map;function T(e,r,a){let l=a?.cacheNamespace||H,s=_.get(l)||_.set(l,new c.Cache({namespace:a?.cacheNamespace})).get(l);if(!s)throw new Error("Missing cache");let p=v(e),m=v(r),g=(0,h.useSyncExternalStore)(s.subscribe,()=>{try{return s.get(p.current)}catch(i){console.error("Could not get Cache data:",i);return}}),o=(0,h.useMemo)(()=>{if(typeof g<"u"){if(g==="undefined")return;try{return JSON.parse(g,K)}catch(i){return console.warn("The cached data is corrupted",i),m.current}}else return m.current},[g,m]),u=v(o),d=(0,h.useCallback)(i=>{let f=typeof i=="function"?i(u.current):i;if(typeof f>"u")s.set(p.current,"undefined");else{let y=JSON.stringify(f,B);s.set(p.current,y)}return f},[s,p,u]);return[o,d]}var S=require("node:crypto");var C="useandom-26T198340PX75pxJACKVERYMINDBUSHWOLF_GQZbfghjklqvwyzrict";var J=128,b,$;function Z(e){!b||b.length<e?(b=Buffer.allocUnsafe(e*J),S.webcrypto.getRandomValues(b),$=0):$+e>b.length&&(S.webcrypto.getRandomValues(b),$=0),$+=e}function U(e=21){Z(e|=0);let r="";for(let a=$-e;a<$;a++)r+=C[b[a]&63];return r}var P={id:"conventional-commits-style",name:"Conventional Style",prompt:`
You are a Git commit message generator. Analyze the git diff and create a conventional commit message.

Format:
<type>(<scope>): <description>

- <change 1>
- <change 2>

Types: feat, fix, refactor, docs, style, test, chore, perf, ci, build
- Keep title under 50 characters
- Use imperative mood ("add" not "added")
- Focus on WHAT changed, not why
- Omit body if changes are trivial

Output only the commit message, no markdown or extra text.
`.trim(),model:"Google_Gemini_2.5_Flash"},q={id:"gitmoji-style",name:"Gitmoji Style",icon:"\u{1F3A8}",prompt:`
You are a Git commit message generator. Analyze the git diff and create a gitmoji-style commit message.

Format:
:emoji: (<scope>): <description>

- <change 1>
- <change 2>

Common emojis:
- \u2728 - New feature
- \u{1F41B} - Bug fix
- \u{1F4DD} - Documentation changes
- \u{1F484} - UI/style improvements
- \u267B\uFE0F - Code refactoring
- \u{1F525} - Removing code/files
- \u2705 - Adding tests
- \u{1F680} - Performance improvements
- \u{1F527} - Configuration changes
- \u{1F4E6} - Dependency updates

- Keep title under 50 characters
- Use imperative mood ("add" not "added")
- Focus on WHAT changed, not why
- Choose the most appropriate emoji for the change
- Omit body if changes are trivial

Output only the commit message, no markdown or extra text.
`.trim(),model:"Google_Gemini_2.5_Flash"},Y={id:"minimalist-style",name:"Minimalist Style",icon:"\u{1F518}",prompt:`
You are a Git commit message generator. Analyze the git diff and create a short, one-line commit message.

- Keep it under 50 characters.
- Describe WHAT changed.
- No prefixes, scopes, or emojis.

Output only the commit message, no markdown or extra text.
`.trim(),model:"Google_Gemini_2.5_Flash"};function A(){let[e,r]=T("ai-prompt-presets",{presets:[P,q,Y],defaultPresetId:P.id}),a=e.presets.find(o=>o.id===e.defaultPresetId)??P,l=e.presets.filter(o=>o.id!==e.defaultPresetId);return{defaultPreset:a,otherPresets:l,addPreset:(o,u,d)=>{let i={id:U(),...I(o),prompt:u,model:d};r(f=>({...f,presets:[...f.presets,i]}))},updatePreset:(o,u,d,i)=>{r(f=>({...f,presets:f.presets.map(y=>y.id===o?{...y,...I(u),prompt:d,model:i}:y)}))},deletePreset:o=>{r(u=>({...u,presets:u.presets.filter(d=>d.id!==o)}))},setDefault:o=>{r(u=>u.presets.some(d=>d.id===o)?{...u,defaultPresetId:o}:u)}}}function I(e){let r=e.match(new RegExp("^(\\p{Emoji}(\\p{Emoji_Modifier}|\\p{Emoji_Component})*)\\s+(.+)$","u"));if(r){let[,a,,l]=r;return{icon:a,name:l}}return{name:e}}var n=require("react/jsx-runtime");function D(){let{defaultPreset:e,otherPresets:r,deletePreset:a,setDefault:l}=A();return(0,n.jsxs)(t.List,{navigationTitle:"AI Message Prompts",searchBarPlaceholder:"Search presets by name...",actions:(0,n.jsx)(t.ActionPanel,{children:(0,n.jsx)(t.Action.Push,{title:"Add New Preset",icon:t.Icon.Plus,shortcut:{modifiers:["cmd"],key:"n"},target:(0,n.jsx)(w,{})})}),children:[(0,n.jsx)(t.List.Section,{title:"Default Preset",children:(0,n.jsx)(O,{preset:e,isDefault:!0})}),(0,n.jsxs)(t.List.Section,{title:"Other Presets",children:[r.map(s=>(0,n.jsx)(O,{preset:s,isDefault:!1,onDelete:()=>a(s.id),onSetDefault:()=>l(s.id)},s.id)),(0,n.jsx)(t.List.Item,{title:"Add New Preset",icon:{source:t.Icon.Plus,tintColor:t.Color.SecondaryText},actions:(0,n.jsx)(t.ActionPanel,{children:(0,n.jsx)(M,{})})})]})]})}function O({preset:e,isDefault:r,onDelete:a,onSetDefault:l}){let s=async()=>{await(0,t.confirmAlert)({title:"Delete Preset",message:`Are you sure you want to delete preset "${e.name}"?`,primaryAction:{title:"Delete",style:t.Alert.ActionStyle.Destructive}})&&a?.()};return(0,n.jsx)(t.List.Item,{icon:e.icon?e.icon:{source:t.Icon.Message,tintColor:t.Color.SecondaryText},title:e.name,accessories:[{text:e.model?e.model.replaceAll("_"," "):"Auto"}],actions:(0,n.jsxs)(t.ActionPanel,{children:[(0,n.jsxs)(t.ActionPanel.Section,{title:e.name,children:[!r&&(0,n.jsx)(t.Action,{title:"Set as Default",icon:t.Icon.Star,onAction:l}),(0,n.jsx)(t.Action.Push,{title:"Edit Preset",icon:t.Icon.Pencil,target:(0,n.jsx)(w,{initialPreset:e}),shortcut:{modifiers:["cmd"],key:"e"}}),(0,n.jsx)(t.Action.Push,{title:"Duplicate Preset",icon:t.Icon.Duplicate,target:(0,n.jsx)(w,{initialPreset:{...e,id:void 0,name:`${e.name} copy`}}),shortcut:{modifiers:["cmd"],key:"d"}}),!r&&(0,n.jsx)(t.Action,{title:"Delete Preset",icon:t.Icon.Trash,style:t.Action.Style.Destructive,onAction:s,shortcut:{modifiers:["ctrl"],key:"x"}})]}),(0,n.jsx)(M,{})]})})}function M(){return(0,n.jsx)(t.Action.Push,{title:"Add New Preset",icon:t.Icon.Plus,shortcut:{modifiers:["cmd"],key:"n"},target:(0,n.jsx)(w,{})})}function w({initialPreset:e}){let{pop:r}=(0,t.useNavigation)(),{addPreset:a,updatePreset:l}=A(),[s,p]=(0,x.useState)(`${e?.icon??""} ${e?.name??""}`.trim()),[m,g]=(0,x.useState)(e?.prompt??""),[o,u]=(0,x.useState)(e?.model??"auto"),d=i=>{let f=i.model==="auto"?void 0:i.model;e?.id?l(e.id,i.name.trim(),i.prompt.trim(),f):a(i.name.trim(),i.prompt.trim(),f),r()};return(0,n.jsxs)(t.Form,{navigationTitle:e?"Edit Preset":"Add Preset",actions:(0,n.jsx)(t.ActionPanel,{children:(0,n.jsx)(t.Action.SubmitForm,{title:e?"Save Changes":"Create Preset",onSubmit:d})}),children:[(0,n.jsx)(t.Form.TextField,{id:"name",title:"Name",placeholder:"e.g., Conventional Commits",value:s,error:s.trim().length===0?"Required":void 0,onChange:p}),(0,n.jsx)(t.Form.TextArea,{id:"prompt",title:"Prompt",placeholder:"Write system prompt for AI commit generation...",value:m,error:m.trim().length===0?"Required":void 0,onChange:g}),(0,n.jsxs)(t.Form.Dropdown,{id:"model",title:"AI Model",value:o??"auto",onChange:u,children:[(0,n.jsx)(t.Form.Dropdown.Item,{value:"auto",title:"Auto"}),Object.keys(t.AI.Model).map(i=>(0,n.jsx)(t.Form.Dropdown.Item,{title:i.replaceAll("_"," "),value:i},i))]}),(0,n.jsx)(t.Form.Description,{text:"Prompt is used to generate commit message based on diff content. It will be available via 'Generate Commit Message' action in Commit Message Form."})]})}0&&(module.exports={AiMessagePresetEditorForm});

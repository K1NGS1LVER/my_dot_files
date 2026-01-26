#!/usr/bin/env python3
import os
import sys
import ast
from pathlib import Path

# Configuration
IGNORE_DIRS = {'.git', '__pycache__', '.pytest_cache', '.mypy_cache', '.DS_Store', 'site-packages'}
IGNORE_FILES = {'.DS_Store', '.gitignore'}

# Registry of known descriptions (seeded with project-specific context)
KNOWN_DESCRIPTIONS = {
    ".venv": "Parent virtual environment",
    "app": "Main application code",
    "core": "Core logic (Config, DB, Engine)",
    "config.py": "Central settings & environment",
    "database.py": "SQLite management",
    "engine.py": "FAISS & SentenceTransformer",
    "server.py": "FastAPI Server (REST API)",
    "ingest.py": "Documentation Ingestion Tool",
    "data": "Persistent data (SQLite + FAISS)",
    "docs.db": "SQLite database for docs",
    "my_index.faiss": "Vector search index",
    "scripts": "Utility/Helper scripts",
    "run_server.sh": "Convenient startup script",
    "fastapi": "Your source documentation",
    "server.log": "Current server logs",
    "README.md": "Project documentation",
    "requirements.txt": "Python dependencies",
    "pyproject.toml": "Build system & configuration",
}

def get_description(path: Path):
    """
    Tries to find a description for a file/folder.
    Priority:
    1. KNOWN_DESCRIPTIONS dictionary.
    2. Python docstrings (for .py files).
    3. Top-level comments (for .py, .sh files).
    4. Generic fallback based on extension.
    """
    name = path.name
    
    # 1. Check known descriptions
    if name in KNOWN_DESCRIPTIONS:
        return KNOWN_DESCRIPTIONS[name]
    
    if path.is_dir():
        return ""

    # 2 & 3. Parse file content for descriptions
    try:
        # Limit read to first 500 bytes to save time/memory
        try:
            content = path.read_text(encoding='utf-8', errors='ignore')[:1000]
        except Exception:
            return ""

        # Strategy for Python files: AST for Docstring
        if path.suffix == '.py':
            try:
                # We need to parse more content to ensure valid AST if possible, 
                # but partial parsing might fail. Let's try parsing the head.
                # If that fails, fallback to simple string checking.
                module = ast.parse(content)
                docstring = ast.get_docstring(module)
                if docstring:
                    return docstring.split('\n')[0].strip()
            except Exception:
                pass
            
            # Fallback: Check for top-level comments starting with #
            lines = content.splitlines()
            for line in lines:
                stripped = line.strip()
                if stripped.startswith('#') and not stripped.startswith('#!'):
                    comment = stripped.lstrip('#').strip()
                    # Filter out encoding declarations or standard lint ignores if needed
                    if "coding:" not in comment:
                        return comment
                    break

        # Strategy for Shell scripts
        if path.suffix == '.sh':
            lines = content.splitlines()
            for line in lines:
                stripped = line.strip()
                if stripped.startswith('#') and not stripped.startswith('#!'):
                    return stripped.lstrip('#').strip()

    except Exception:
        pass

    # 4. Fallbacks
    if path.suffix == '.py': return "Python Source"
    if path.suffix == '.md': return "Documentation"
    if path.suffix == '.json': return "JSON Data"
    if path.suffix == '.log': return "Log File"
    if path.suffix == '.sh': return "Shell Script"
    
    return ""

def generate_tree(dir_path: Path, prefix: str = "", counter: int = 1):
    """
    Recursive generator that yields lines for the tree structure.
    Returns a tuple: (line_string, next_counter)
    """
    # Get all children, sorted naturally (dirs first? or alpha? tree usually does alpha)
    try:
        entries = sorted([p for p in dir_path.iterdir() 
                          if p.name not in IGNORE_DIRS and p.name not in IGNORE_FILES],
                         key=lambda x: (not x.is_dir(), x.name.lower()))
    except PermissionError:
        return

    total = len(entries)
    
    for index, entry in enumerate(entries):
        is_last = (index == total - 1)
        
        connector = "└── " if is_last else "├── "
        
        description = get_description(entry)
        desc_str = f"  # {description}" if description else ""
        
        # Format the line: " 1 ├── name # description"
        # We allow dynamic padding for the line number for cleaner look up to 999 lines
        line_str = f"{counter:4} {prefix}{connector}{entry.name:<20}{desc_str}"
        print(line_str)
        
        counter += 1
        
        if entry.is_dir():
            extension = "    " if is_last else "│   "
            counter = generate_tree(entry, prefix + extension, counter)
            
    return counter

def main():
    start_dir = Path.cwd()
    if len(sys.argv) > 1:
        potential_path = Path(sys.argv[1])
        if potential_path.is_dir():
            start_dir = potential_path

    print(f"{start_dir.name}/")
    generate_tree(start_dir)

if __name__ == "__main__":
    main()

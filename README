# Johnny.Decimal Folder Setup for Obsidian

This project automates the creation of a comprehensive, multi-level [Johnny.Decimal](https://johnnydecimal.com/) folder structure for use in an Obsidian vault (or any other system). It also provides specialized markdown templates for different categories, ensuring consistent note-taking.

## What is Johnny.Decimal?

Johnny.Decimal is an organizational system that helps you structure your files and folders in a logical, numerical way. It uses a hierarchical structure:

- **Areas** (10-19, 20-29, etc.) - Broad categories of information
- **Categories** (11, 12, 13, etc.) - Specific topics within an area
- **IDs** (11.01, 11.02, etc.) - Individual items within a category

This system makes it easy to find information, maintain organization, and prevent folder sprawl.

## Contents

1. **`setup_jd.sh`**  
   A bash script that reads a lines-based configuration from `jd_structure.txt` and creates all folders accordingly.  
   - Each "final folder" gets a markdown file named after the folder, based on the template type (e.g., `inbox`, `archive`, `deal_memo`, or `generic`).

2. **`jd_structure.txt.example`**  
   An example configuration file showing how to structure your Johnny.Decimal system.
   - You'll rename this to `jd_structure.txt` and customize it for your needs.

3. **`README.md`** (this file)  
   Explains what the project is, how to install and run it, and how to customize your Johnny.Decimal configuration.

## Setup Instructions

### 1. Prepare Your Configuration

First, create your own configuration file by renaming the example:

```bash
cp jd_structure.txt.example jd_structure.txt
```

### 2. Customize Your Structure

Edit the `jd_structure.txt` file to match your desired Johnny.Decimal system:

```bash
nano jd_structure.txt  # or use any text editor you prefer
```

Each line in the file follows this format:
```
<Area> | <Category> | <Final Folder> | <TemplateType>
```

For example:
```
10-19 Personal|11 🙋 Identity & Documents|11.10 ■ Documents 📑|generic
```

- **Area**: The broad category (e.g., "10-19 Personal")
- **Category**: A subcategory (e.g., "11 🙋 Identity & Documents")
- **Final Folder**: The specific folder (e.g., "11.10 ■ Documents 📑")
- **Template Type**: The type of template to use (optional, defaults to "generic")
  - Available templates: `generic`, `inbox`, `archive`, `deal_memo`

Lines starting with `#` are treated as comments and ignored.

### 3. Make the Script Executable

```bash
chmod +x setup_jd.sh
```

### 4. Run the Script

```bash
./setup_jd.sh
```

The script will:
1. Create the entire folder structure defined in your `jd_structure.txt`
2. Generate appropriate markdown files in each final folder
3. Name each markdown file after its containing folder (with special characters handled properly)

### 5. Explore Your New Structure

After running the script, you'll have a complete Johnny.Decimal folder structure in the `Johnny.Decimal` directory. You can:

- Move this into your Obsidian vault
- Use it as a standalone organizational system
- Customize the templates further by editing the `get_template()` function in the script

## Customizing Templates

The script includes several predefined templates:

- **generic**: A general-purpose template for most notes
- **inbox**: For temporary storage of unsorted items
- **archive**: For long-term storage of completed items
- **deal_memo**: A specialized template for deal memos (if applicable)

You can customize these templates by editing the `get_template()` function in the `setup_jd.sh` script.

## Example Structure

The example structure includes areas for:

- **00-09 Meta System**: System-level organization
- **10-19 Personal**: Personal life management
- **20-29 Professional**: Career and skills
- **30-39 Business**: Business operations
- **40-49 Projects**: Project management
- **50-59 Knowledge**: Learning and ideas
- **90-99 Archive**: Archived materials

Feel free to adapt this structure to your specific needs!

## Compatibility

This script is designed to work with:
- macOS
- Linux
- Any system with a bash-compatible shell
- Older bash versions (no advanced features required)

## License

This project is open source and available for anyone to use and modify.

---

Happy organizing!



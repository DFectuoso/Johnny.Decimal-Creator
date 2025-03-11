#!/usr/bin/env bash
#
# setup_jd.sh
# Reads a lines-based config (jd_structure.txt) and creates
# a multi-level Johnny.Decimal folder structure with specialized
# template.md for each final folder, supporting older bash shells
# that do NOT have 'declare -A' or advanced features.

# -----------------------------------------------------------
# 1) Define the BASE DIR (no extra quotes here).
# -----------------------------------------------------------
BASE_DIR=Johnny.Decimal
mkdir -p "$BASE_DIR"

# -----------------------------------------------------------
# 2) get_template() function with simple case statements
# -----------------------------------------------------------
get_template() {
  local type="$1"
  local item_name="$2"
  local date_now="$(date +'%Y-%m-%d')"

  # We'll store our multi-line output in a variable 'out'
  # using a heredoc inside case blocks, then echo it.

  case "$type" in

    inbox)
      cat <<EOF
---
title: "$item_name - Inbox"
created: "$date_now"
tags: [inbox]
---

# $item_name - Inbox

Use this folder to hold unsorted items briefly.

## 📥 Quick Capture
- [ ] Task or note

## 🗒️ Next Steps
- [ ] Sort these items properly
EOF
      ;;

    archive)
      cat <<EOF
---
title: "$item_name - Archive"
created: "$date_now"
tags: [archive]
---

# $item_name - Archive

## 📦 Purpose
Long-term storage.

## 🔖 Notes
- 
EOF
      ;;

    deal_memo)
      cat <<EOF
---
title: "$item_name - Deal Memo"
created: "$date_now"
tags: [deal_memo]
---

# Deal Memo: $item_name

## Investment Thesis
- 

## Risks
- 

## Next Steps
- [ ] 

## Links & References
- [Link](url)
EOF
      ;;

    # Fallback or generic default
    *)
      cat <<EOF
---
title: "$item_name"
created: "$date_now"
tags: []
---

# $item_name

## 🔖 Description
A short description of what belongs here.

## 🗒️ Notes
- 

## ✅ Actions
- [ ] 

## 🔗 Related Links
- [Link](url)
EOF
      ;;
  esac
}

# -----------------------------------------------------------
# 3) Check for jd_structure.txt
# -----------------------------------------------------------
STRUCTURE_FILE=jd_structure.txt
if [[ ! -f "$STRUCTURE_FILE" ]]; then
  echo "Error: '$STRUCTURE_FILE' not found. Please create or place it in the same directory."
  exit 1
fi

echo "Creating Johnny.Decimal structure in '$BASE_DIR' from '$STRUCTURE_FILE'..."

# -----------------------------------------------------------
# 4) Read each line in jd_structure.txt and create folders
# -----------------------------------------------------------
# Format per line:  <Area> | <Category> | <Final Folder> | <TemplateType>
# e.g.: 10-19 Life Admin|11 🙋 Yo...|11.00 ■ Personal mgmt|generic
# If <TemplateType> is omitted, we default to 'generic'

while IFS='|' read -r area category final_folder template_type; do
  # Skip empty or comment lines (#)
  [[ -z "$area" || "$area" =~ ^# ]] && continue
  
  # Default to 'generic' if no template type
  if [[ -z "$template_type" ]]; then
    template_type="generic"
  fi

  # Build paths
  area_path="$BASE_DIR/$area"
  category_path="$area_path/$category"
  final_path="$category_path/$final_folder"

  # Create directories
  mkdir -p "$final_path"

  # Process the final folder name to create a clean filename
  # 1. First replace & with "and"
  # 2. Then replace emoji and special characters with spaces
  # 3. Normalize spaces (no double spaces)
  # 4. Trim leading/trailing spaces
  clean_name=$(echo "$final_folder" | sed -E 's/&/ and /g')
  clean_name=$(echo "$clean_name" | sed -E 's/[^[:alnum:][:space:]\.\_\-]/ /g')
  clean_name=$(echo "$clean_name" | sed -E 's/[[:space:]]+/ /g' | sed -E 's/^[[:space:]]+//' | sed -E 's/[[:space:]]+$//')
  
  # Generate the template content
  template_content="$(get_template "$template_type" "$final_folder")"

  # Write file named after the final folder inside the final folder
  echo "$template_content" > "$final_path/$clean_name.md"

done < "$STRUCTURE_FILE"

echo "✅ Done! Explore '$BASE_DIR' for the full multi-level Johnny.Decimal structure."

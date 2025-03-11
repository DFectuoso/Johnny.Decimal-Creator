#!/usr/bin/env bash
#
# setup_jd.sh
# Reads a lines-based config (jd_structure.txt) and creates
# a multi-level Johnny.Decimal folder structure with
# specialized template.md for each final folder.

BASE_DIR=\"Johnny.Decimal\"
mkdir -p \"$BASE_DIR\"

# ------------------------
# 1. Define Template Types
# ------------------------
declare -A TEMPLATES

# 1.1 Generic default template
TEMPLATES[generic]=\"---\\ntitle: '{{ITEM_NAME}}'\\ncreated: '{{DATE}}'\\ntags: []\\n---\\n\\n# {{ITEM_NAME}}\\n\\n## 🔖 Description\\nDescription of what belongs here.\\n\\n## 🗒️ Notes\\n- \\n\\n## ✅ Actions\\n- [ ] \\n\\n## 🔗 Related Links\\n- [Link](url)\\n\"

# 1.2 Inbox
TEMPLATES[inbox]=\"---\\ntitle: '{{ITEM_NAME}} - Inbox'\\ncreated: '{{DATE}}'\\ntags: [inbox]\\n---\\n\\n# {{ITEM_NAME}} - Inbox\\n\\nUse this folder to hold unsorted items briefly.\\n\\n## 📥 Quick Capture\\n- [ ] Task or note\\n\\n## 🗒️ Next Steps\\n- [ ] Sort these items properly\\n\"

# 1.3 Archive
TEMPLATES[archive]=\"---\\ntitle: '{{ITEM_NAME}} - Archive'\\ncreated: '{{DATE}}'\\ntags: [archive]\\n---\\n\\n# {{ITEM_NAME}} - Archive\\n\\n## 📦 Purpose\\nLong-term storage.\\n\\n## 🔖 Notes\\n- \\n\"

# 1.4 Example specialized template (Deal Memos)
TEMPLATES[deal_memo]=\"---\\ntitle: '{{ITEM_NAME}} - Deal Memo'\\ncreated: '{{DATE}}'\\ntags: [deal_memo]\\n---\\n\\n# Deal Memo: {{ITEM_NAME}}\\n\\n## Investment Thesis\\n- \\n\\n## Risks\\n- \\n\\n## Next Steps\\n- [ ] \\n\\n## Links & References\\n- [Link](url)\\n\"

# ------------------------
# 2. Read jd_structure.txt
# ------------------------
structure_file=\"jd_structure.txt\"

if [[ ! -f \"$structure_file\" ]]; then
  echo \"Error: '$structure_file' not found. Please create it and list your system lines.\"
  exit 1
fi

echo \"Creating Johnny.Decimal structure in '$BASE_DIR' from '$structure_file'...\"

# Each line can have up to 4 fields: Area|Category|Item|TemplateType
while IFS='|' read -r area category final_folder template_type; do
  # Skip empty or comment lines
  [[ -z \"$area\" || \"$area\" =~ ^# ]] && continue
  
  # If no template_type is provided, default to 'generic'
  [[ -z \"$template_type\" ]] && template_type=\"generic\"
  
  # Build the full path
  area_path=\"$BASE_DIR/$area\"
  category_path=\"$area_path/$category\"
  item_path=\"$category_path/$final_folder\"
  
  mkdir -p \"$item_path\"
  
  # Grab the template from TEMPLATES map
  # If not found, fallback to 'generic'
  template_content=\"${TEMPLATES[$template_type]}\"  
  if [[ -z \"$template_content\" ]]; then
    template_content=\"${TEMPLATES[generic]}\"
  fi
  
  # Replace placeholders
  date_now=\"$(date +'%Y-%m-%d')\"
  template_content=\"${template_content//'{{DATE}}'/$date_now}\"
  template_content=\"${template_content//'{{ITEM_NAME}}'/$final_folder}\"
  
  # Write to template.md
  echo -e \"$template_content\" > \"$item_path/template.md\"
  
done < \"$structure_file\"

echo \"✅ Done! Explore your '$BASE_DIR' folder for the full structure.\"


#!/bin/bash

NOTES_FOLDER="$HOME/Notes"
cd "$NOTES_FOLDER"
option="$1"
# Get the title from the first argument
title="$2"
arg2="$2"
# Get directory at which create the file
folder_name="$3"

# Lowercase and replace spaces in the title with dashes to create the filename
filename=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
output_file="$NOTES_FOLDER/$folder_name/$filename.md"

generate_output() {
  echo "---"
  echo "title: $1" # Pass the title as the first argument to the script
  echo  "date: $(date +"%Y-%m-%d")" # Use the current date as the "date" field in the front matter
  echo  "time: $(date +"%H:%M")"
  echo "description: Note description here"
  echo "tags: "
  echo "---"
}

help_message() {
  echo "Usage:"
  echo "vadim new <title> <category> - create new note"
  echo "vadim open - open directory with NeoVim"
  echo "vadim help - print this message"
  echo "vadim list - print all directories inside your notes folder"
  echo "vadim list <path> - print all directories inside specified folder"
  echo "Your notes are stored in: $NOTES_FOLDER"
  exit 1
}

list_all() {
  echo "Folders and files in main directory:"
  ls -1 $NOTES_FOLDER/
}

list_category() {
  echo "Folders and files in directory $1:"
  ls -1 "$NOTES_FOLDER/$1"
}

open() {
  nvim "$NOTES_FOLDER"
}

if [ -z "$1" ]; then
  echo "Use 'vadim help' command to see all options"
fi

if [ "$option" = "new" ]; then
      # Create the Markdown file
      if [ -d $NOTES_FOLDER/$folder_name ]; then
          if [[ "$title" = "" ]]; then
           echo "Please, specify title of your note in order to create new file." 
          else
            generate_output "$title" > "$output_file"
            echo "Markdown file '$output_file' created successfully!"

          fi
      else
          read -p "There's no such folder. Do you want to create the directory and put the note in it? Y/n: "$is_agree
          if [[ "$is_agree" = "y" || -z "$is_agree" ]]; then
            # create new folder for current file
            mkdir "$HOME/Notes/$folder_name"
            generate_output "$title" > "$output_file"
            echo "New directory created successfully."
            echo "Markdown file '$output_file' created successfully!"
          else
            echo "OK. Exiting..."
            exit 1
          fi
    fi
fi

if [[ "$option" = "help" ]]; then
 help_message 
fi

if [[ "$option" = "open" ]]; then
  open 
fi

if [[ "$option" = "delete" && -n "$arg2" ]]; then
  delete_note $arg2 
fi

if [[ "$option" = "list" && -z "$arg2" ]]; then
 list_all 
fi

if [[ "$option" = "list" && -n "$arg2" && "$arg2" != "all" ]]; then
 list_category $arg2 
fi

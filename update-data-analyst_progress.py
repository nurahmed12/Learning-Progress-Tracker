#!/usr/bin/env python3
import json
import sys

def main():
    if len(sys.argv) != 3:
        print("Usage: python update_progress.py \"Stage N\" \"Topic Name\"")
        return
    stage, topic = sys.argv[1], sys.argv[2]
    with open('progress.json', 'r') as f:
        data = json.load(f)
    if stage in data and topic in data[stage]:
        data[stage][topic] = True
        with open('progress.json', 'w') as f:
            json.dump(data, f, indent=2)
        print(f"✔ Marked '{topic}' as done in {stage}")
    else:
        print("Error: check stage/topic names match exactly")

if __name__ == '__main__':
    main()

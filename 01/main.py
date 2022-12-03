# PART 1
max_elf_calories = 0
current_elf_calories = 0

with open("01/input.txt", "r") as input:
    elfs_notes = input.readlines()

for line in elfs_notes:
    if line == "\n":
        current_elf_calories = 0
    else:
        current_elf_calories += int(line)

    if max_elf_calories < current_elf_calories:
        max_elf_calories = current_elf_calories

print(max_elf_calories)

# PART 2
elf_calories_list = []
current_elf_calories = 0

for line in elfs_notes:
    if line == "\n":
        elf_calories_list.append(current_elf_calories)
        current_elf_calories = 0
    else:
        current_elf_calories += int(line)

print(sum(sorted(elf_calories_list)[-3:]))

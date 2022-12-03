# PART 1
with open("03/input.txt", "r") as elf_notes:
    rucksacks_list = elf_notes.readlines()

# 97 stands for "a"
# 65 stands for "A"
def check_priority(object: str):
    ascii_position = ord(object)
    # substract one less so "a" returns 1
    return (ascii_position - 64 + 26) if ascii_position < 97 else ascii_position - 96


overlapping_objects = []
for rucksack in rucksacks_list:
    middle = len(rucksack) // 2
    compartment_a, compartment_b = set(rucksack[:middle]), set(rucksack[middle:])
    intersection = next(iter(compartment_a.intersection(compartment_b)))
    overlapping_objects.append(intersection)

# ascii conversion test
# for line in zip(overlapping_objects, map(check_priority, overlapping_objects)):
#     letter, score = line
#         print(score)
#     if letter == "B":

print(sum(map(check_priority, overlapping_objects)))

# PART 2
def group_sticker(groups: list[str]):
    intersection = set(groups[0]) & set(groups[1]) & set(groups[2])
    return check_priority(next(iter(intersection)))


groups = []
output = 0
for i, rucksack in enumerate(rucksacks_list, 1):
    groups.append(rucksack.rstrip())
    if i % 3 == 0:
        output += group_sticker(groups)
        groups.clear()

print(output)

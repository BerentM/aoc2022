# PART 1
# A X - rock
# B Y - paper
# C Z - scissors

# 0 is lose
# 1 is tie
# 2 is win
my_pick = {
    "A": {
        "X": 3,
        "Y": 6,
        "Z": 0,
    },
    "B": {
        "X": 0,
        "Y": 3,
        "Z": 6,
    },
    "C": {
        "X": 6,
        "Z": 3,
        "Y": 0,
    },
}

points_for_selected = {
    "X": 1,
    "Y": 2,
    "Z": 3,
}

total_score = 0
with open("02/input.txt", "r") as strategy:
    for match in strategy:
        enemy, me = match.rstrip("\n").split(" ")
        total_score += my_pick[enemy][me] + points_for_selected[me]

print(total_score)

# PART 2
# B - paper
# A - rock
# C - scissors

# X lose
# Y draw
# Z win

my_pick = {
    "A": {
        "X": "C",
        "Y": "A",
        "Z": "B",
    },
    "B": {
        "X": "A",
        "Y": "B",
        "Z": "C",
    },
    "C": {
        "X": "B",
        "Y": "C",
        "Z": "A",
    },
}

points_for_selected = {
    "A": 1,
    "B": 2,
    "C": 3,
}

game_output = {
    "X": 0,
    "Y": 3,
    "Z": 6,
}

total_score = 0
with open("02/input.txt", "r") as strategy:
    for match in strategy:
        enemy, me = match.rstrip("\n").split(" ")
        total_score += points_for_selected[my_pick[enemy][me]] + game_output[me]

print(total_score)

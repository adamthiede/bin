#!/usr/bin/env python
import random

def roll(sides, amount=1, mod=0):
    print(f"Rolling {amount} D{sides}...")
    rolls=[]
    for x in range(0,amount):
        roll=random.randint(1,sides)
        rolls.append(roll)
    if amount>1:
        total=sum(rolls)+mod
        if mod>0:
            print(f"Total: {total}, Rolls: {rolls}, Mod: {mod}")
        else:
            print(f"Total: {total}, Rolls: {rolls}")
    else:
        print(rolls)
print("Type numbers only.")
print("Type # of dice, sides, and modifier, followed by Enter.")
print("Amount and modifier are optional.")
while True:
    print("Roll:")
    choice=input().strip()
    if choice=="q" or choice=="Q":
        print("Game Over")
        exit()
    if choice=="":
        print("Default.")
        roll(sides=20)
        continue

    val=choice.split(" ")
    if len(val)==1:
        roll(sides=int(val[0]))
    elif len(val)==2:
        roll(sides=int(val[1]), amount=int(val[0]))
    elif len(val)==3:
        roll(sides=int(val[1]), amount=int(val[0]), mod=int(val[2]))
    else:
        print("input some correct values.")


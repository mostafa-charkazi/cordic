from math import atan, degrees
angle = int(input("Enter Angle: "))
znew = angle
xnew = 0.607252941041397
ynew = 0

for i in range(0,12):
    if znew < 0:
        d = -1
    else:
        d = 1
    
    theta = degrees(atan(2**(-i))) #LUT
    xold = xnew                    
    yold = ynew
    zold = znew

    xnew = xold - d * yold * (2**(-i))
    ynew = yold + d * xold * (2**(-i))
    znew = zold - d * theta


print(f"sin({angle}) = {ynew}")
print(f"cos({angle}) = {xnew}")
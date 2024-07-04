clc;clear
angle = input("Enter Angle: ");
znew = angle;
xnew = 0.607252941041397;
ynew = 0;

for i=0:11
    if(znew < 0)
        d = -1;
    else
        d = 1;
    end
    theta = atand(2^(-i));
    xold = xnew;
    yold = ynew;
    zold = znew;

    xnew = xold - d * yold * 2^-i;
    ynew = yold + d * xold * 2^-i;
    znew = zold - d * theta;
end

disp(['sin(' num2str(angle) ') = ' num2str(ynew)]);
disp(['cos(' num2str(angle) ') = ' num2str(xnew)]);
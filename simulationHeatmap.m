% Initialize
clear all, close all, clc

BSmag.Nfilament = 0; %Number of source filament 

% Source points (where there is a current source)
theta = linspace(-16*2*pi,16*2*pi,20*100);
Gamma = 3*[cos(theta'),sin(theta'),theta'/100]; % x,y,z (cm,cm,cm)
Gamma2 = [cos(theta')-3,sin(theta'),theta'/100 + 2.9]; % x,y,z (cm,cm,cm)
%Rotate with rotation matrix about
Gamma2 = Gamma2*[cos(-pi/4) 0 sin(-pi/4); 0 1 0; -sin(-pi/4) 0 cos(-pi/4)]; %-pi/4 about y axis
Gamma2 = 3*Gamma2*[cos(pi/6) -sin(pi/6) 0; sin(pi/6) cos(pi/6) 0; 0 0 1]; %pi/6 about x axis
I1 = 0.803125; % solenoid 1 current (A)
I2 = -0.8375; %solenoid 2 current (A)
dGamma = 1e9; % filament max discretization step [m]
[BSmag] = BSmag_add_filament(BSmag,Gamma,I1*10*10*10,dGamma); %the two filaments
[BSmag] = BSmag_add_filament(BSmag,Gamma2,I2*10*10*10,dGamma); %times 1e4 for current because we use centimetre scale, B varies with 1/(r^2)

% Field points (where we want to calculate the field)
x_M = linspace(-10,10,30); % x (cm)
y_M = linspace(-10,10,30); % y (cm)
z_M = linspace(-10,25,40); % z (cm)
[X_M,Y_M,Z_M]=meshgrid(x_M,y_M,z_M);

% Biot-Savart Integration
[BSmag,X,Y,Z,BX,BY,BZ] = BSmag_get_B(BSmag,X_M,Y_M,Z_M);


% Plot B on the volume
figure(2), hold on, box on, grid on
	plot3(Gamma(:,1),Gamma(:,2),Gamma(:,3),'.-r') % plot filament
    plot3(Gamma2(:,1),Gamma2(:,2),Gamma2(:,3),'.-r') % plot filament
	slice(X,Y,Z,BZ,[0],[],[0, 5, 10, 15])
    c = colorbar; % plot Bz
    ylabel(c, 'B Magnitude (T) \rightarrow');
    xpts = [5, -5, 5, -5];
    ypts = [5, -5, 5, -5];
    zpts = [5.5, 5.5, 10.5, 10.5];
    labels = {'1', '2', '3', '4'};
    scatter3(xpts+0.2, ypts, zpts-0.5, 10, 'r', 'filled');
    text(xpts, ypts, zpts, labels, 'Color','r','FontSize',12);
    
xlabel ('x (cm)'), ylabel ('y (cm)'), zlabel ('z (cm)')
view(3), axis equal, axis tight
caxis([-5,5]*1e-4)

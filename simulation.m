% Initialize
clear all, close all, clc

BSmag.Nfilament = 0; %Number of source filament 

% Open default figure to plot source points and field points
figure(1), hold on, grid on, box on, axis equal
xlabel('x (cm)'), ylabel('y (cm)'), zlabel('z (cm)')
view(3), axis tight

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
x_M = linspace(-20,20,25); % x (cm)
y_M = linspace(-20,20,25); % y (cm)
z_M = linspace(-20,20,40); % z (cm)
[X_M,Y_M,Z_M]=meshgrid(x_M,y_M,z_M);
%BSmag_plot_field_points(BSmag,X_M,Y_M,Z_M); % shows the field points volume

% Biot-Savart Integration
[BSmag,X,Y,Z,BX,BY,BZ] = BSmag_get_B(BSmag,X_M,Y_M,Z_M);

% Plot B
figure(1)
    normB=sqrt(BX.^2+BY.^2+BZ.^2);
    [X0,Y0,Z0] = ndgrid(-10:5:10,-10:5:10,-15); % define tubes starting point        
    %quiver3(X,Y,Z,BX./normB,BY./normB,BZ./normB)
    xlim([-15 15])
    ylim([-15 15])
    zlim([-15 20])
    streamline(X,Y,Z,BX./normB,BY./normB,BZ./normB, X0, Y0, Z0)
  
    



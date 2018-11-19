%% plots of vertical distribution of salinity for salt intrusion
clear all;close all;clc

% Load data:
load lock.mat
np=length(Xp);
N =1000;
RGB = [0 150; 0 255; 200 250];
for n=1:N
    blue(n,:) = [RGB(1,1)+n*(RGB(1,2)-RGB(1,1))/N, RGB(2,1)+n*(RGB(2,2)-RGB(2,1))/N, RGB(3,1)+n*(RGB(3,2)-RGB(3,1))/N]/255;
end
c = {blue, cool,parula, winter,bone,gray};
color = 2;
[filepath,name,ext] = fileparts(pwd);

%% Transform data
%{
%RUN this section for new SWASH run results
kmax=100;
tmax=29;
dt = 1;

for i=0:tmax
    t = i*dt;
    t_hms = datevec(t/(86400));
    h=t_hms(4);m=t_hms(5);s=t_hms(6);
    if h >= 10
        t_h = num2str(h);
    else
        t_h = ['0',num2str(h)];
    end
    if m >= 10
        t_m = num2str(m);
    else
        t_m = ['0',num2str(m)];
    end
    if s >= 10
        t_s = num2str(s);
    else
        t_s = ['0',num2str(s)];
    end
    timeString = [t_h,t_m,t_s];
    
    for j=1:np
        for k=1:kmax
            disp(['i=',num2str(i),':',num2str(tmax),', j=',num2str(j),':',num2str(np),', k=',num2str(k),':',num2str(kmax)])
            if k < 10
                %if exist then TODO!
                eval(['s=Salk00' num2str(k) '_20180602_',timeString,';'])
                eval(['z=zk00' num2str(k) '_20180602_',timeString,';'])
            elseif k < 100
                eval(['s=Salk0' num2str(k) '_20180602_',timeString,';'])
                eval(['z=zk0' num2str(k) '_20180602_',timeString,';'])
            else
                eval(['s=Salk' num2str(k) '_20180602_',timeString,';'])
                eval(['z=zk' num2str(k) '_20180602_',timeString,';'])
            end
            sal(j,k,i+1)=s(j);
            zk(j,k,i+1)=z(j);
            x(j,k,i+1)=Xp(j);
        end
        clc;
    end
    save('lock2.mat','sal','zk','x');
end
%}

%% Animation
load lock2.mat;
close all;
figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap(flipud(h));
axis tight manual % this ensures that getframe() returns a consistent size
g = pcolor(x(:,:,1),zk(:,:,1),double(sal(:,:,1)));shading flat;
 
pbaspect([8, 1, 1]);
xlabel('Distance [m]');
ylabel('Level [m]');
axis([0 0.9 -0.1 0])
hh = colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
for a=1:size(sal,3)
    g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
     
    xlabel('Distance [m]');
    ylabel('Level [m]');
    axis([0 0.9 -0.1 0])
    hh=colorbar;
    set(hh,'YTick',0:5:30);
    hh.Label.String = 'Salinity [ppt]';
    title('Non-Hydrostatic Lock exchange')
    hh.Label.String = 'Salinity [ppt]';
    set(gca,'fontsize',14);
    pbaspect([8, 1, 1]);
    pause(0.2);
    delete(g);
end
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
pbaspect([8, 1, 1]);
xlabel('Distance [m]');
ylabel('Level [m]');
axis([0 0.9 -0.1 0])
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);

%% Plot snapsnot
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
a = 1;
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
%b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
%              'value',a, 'min',1, 'max',tmax);
%bgcolor = f.Color;
%b.Callback = @(es,ed) updateSystem(g);
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
pbaspect([8, 1, 1]);

%% Plot snapsnot - t0
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
a = 1;
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
pbaspect([8, 1, 1]);
[filepath,name,ext] = fileparts(pwd);
print(['Images/',name,'_t',num2str(a-1),'.png'],'-dpng');

%% Plot snapsnot - t9
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
a = 10;
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
pbaspect([8, 1, 1]);
[filepath,name,ext] = fileparts(pwd);
print(['Images/',name,'_t',num2str(a-1),'.png'],'-dpng');

%% Plot snapsnot - t19
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
a = 20;
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
pbaspect([8, 1, 1]);
[filepath,name,ext] = fileparts(pwd);
print(['Images/',name,'_t',num2str(a-1),'.png'],'-dpng');

%% Plot snapsnot - t29
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
a = 30;
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
pbaspect([8, 1, 1]);
[filepath,name,ext] = fileparts(pwd);
print(['Images/',name,'_t',num2str(a-1),'.png'],'-dpng');
close all;

%% Safe animation as GIF File
%load lock2.mat;
close all;
f = figure('units','normalized','outerposition',[0 0 1 1]);
h = colormap(c{color});
colormap( flipud(h) );
axis tight manual % this ensures that getframe() returns a consistent size
xlabel('Distance [m]');
ylabel('Level [m]');
axis([0 0.9 -0.1 0])
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);

filename = ['Images/',name,'.gif'];
for a=1:size(sal,3)
    g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
     
    pbaspect([8, 1, 1]);
    xlabel('Distance [m]');
    ylabel('Level [m]');
    axis([0 0.9 -0.1 0])
    hh=colorbar;
    set(hh,'YTick',0:5:30);
    hh.Label.String = 'Salinity [ppt]';
    title('Non-Hydrostatic Lock exchange')
    set(gca,'fontsize',14);
    
    %drawnow;
    pause(0.01);
    %Capture the plot as an image
    M(a) = getframe(f);
    im = frame2im(M(a));
    [imind,cm] = rgb2ind(im,256);
    %Write to GIF File
    if a==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append')
    end
    delete(g);
end
g = pcolor(x(:,:,a),zk(:,:,a),double(sal(:,:,a)));shading flat;
 
pbaspect([8, 1, 1]);
xlabel('x (m)');
ylabel('z (m)');
hh=colorbar;
set(hh,'YTick',0:5:30);
hh.Label.String = 'Salinity [ppt]';
title('Non-Hydrostatic Lock exchange')
set(gca,'fontsize',14);
%axis equal
close all;

%% Animation
%movie(M,2,12);

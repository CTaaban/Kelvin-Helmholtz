xlen = 0.9;                         % size 'grid' [m]
mx = 180;                           % # gridpoints-1 on 'grid' [-]
dx = xlen/mx;                       % length of 'grid'-cell [m]
xx = 0:dx:xlen;                     % total x-interval
xb  = [0, xlen/2-dx,xlen/2, xlen];  % characteristic x-coordinates of dam
sal = [31, 31, 0, 0];               % depth of dam at characteristics [m]
dd = interp1(xb,sal,xx);            % depth at slope of dam [m]
write_matrix(dd','salinity.sal')    % write ANSII matrix of bottom input

%close
%depmin = -max(dep);
plot(xx,dd,'linewidth',2)
grid on
set(gca,'xlim', [0 0.9],'ylim',[min(sal)-1 max(sal)+1], 'fontsize',14)
%pbaspect([(xlen/-depmin), 500, 500])
xlabel('x [m]')
ylabel('d [m]')
title('Salinity step')

function write_matrix(x,fname,form)
%
% write_matrix(x,fname,[format])
%
% Gerbrant van Vledder  !
% 18 Mar 2003  Created
% 12 Feb 2016  Write statement modified \r\n instead of \n
%
% specify default format
% and check optional input format
%
format = '%8.2f';
if nargin ==3
    format=form;
end
%
ny = size(x,1);
nx = size(x,2);
fid = fopen(fname,'w');
%
nymax = 500;
nn    = 1;
if ny>nymax
  h = waitbar(0,['Writing matrix ' addslash(fname)]);
  nn = floor(ny/250);
end;
for iy=1:ny
  if iy==nn*floor(iy/nn) && ny>nymax
     waitbar(iy/ny,h)
  end
  xx = x(iy,:);
  eval(['fprintf(fid,' '''' format '''' ',xx);'])
  fprintf(fid,'%s\r\n',' ');
end
fclose(fid);
if ny>nymax;close(h);end;
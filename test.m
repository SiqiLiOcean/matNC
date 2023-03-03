ncdumclc
clear

fin = 'D:\work\grid\gom5\gom5_grid.nc';
fout = './test.nc';

nc.name = fout;
% Dimensions
nc.dims{1} = {'node', 138567};
nc.dims{2} = {'nele', 252801};
nc.dims{3} = {'three', 3};
% Global attibutes
nc.atts{1} = {'source', 'FVCOM'};
nc.atts{2} = {'author', 'Siqi Li'};
% Variables
nc.vars{1} = nc_var_fvcom('x');
nc.vars{2} = nc_var_fvcom('y');
nc.vars{3} = nc_var_fvcom('nv');
nc.vars{4} = nc_var_fvcom('h');




nc0 = nc_def_header(nc);

x = ncread(fin, 'x');
y = ncread(fin, 'y');
nv = ncread(fin, 'nv');
h = ncread(fin, 'h');


nc_put_var(fout, 'x', x);
nc_put_var(fout, 'y', y);
nc_put_var(fout, 'nv', nv);
nc_put_var(fout, 'h', h);


nc_copy_att(fin, [], fout);


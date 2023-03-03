%==========================================================================
% nc_def_header0    ---   nc_toolbox
%   Define header of a new NetCDF file
%
% input  :
%   nc         --- nc struct
%     |---name
%     |---dims {dim_name, dim_length}
%     |---atts {att_name, att_value}
%     |---vars {var_name, var_type, var_dims, {att1_name, att1_value}, ...}
%
%
% output :
%   \
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function nc0 = nc_def_header(nc)

nc0.name = nc.name;

for i = 1 : length(nc.dims)
    nc0.dims(i).name = nc.dims{i}{1};
    nc0.dims(i).length = nc.dims{i}{2};
end

if isfield(nc, 'atts')
    for i = 1 : length(nc.atts)
        nc0.atts(i).name = nc.atts{i}{1};
        nc0.atts(i).value = nc.atts{i}{2};
    end
end

for i = 1 : length(nc.vars)
    nc0.vars(i).name = nc.vars{i}{1};
    nc0.vars(i).type = nc.vars{i}{2};
    nc0.vars(i).dims = nc.vars{i}{3};
    j = 3;
    while j<length(nc.vars{i})
        j = j+1;
        nc0.vars(i).atts(j-3).name = nc.vars{i}{j}{1};
        nc0.vars(i).atts(j-3).value = nc.vars{i}{j}{2};
    end
end

nc_def_header0(nc0);

end




%==========================================================================
% nc_def_header0    ---   nc_toolbox
%   Define header of a new NetCDF file
%
% input  :
%   nc0        --- nc0 struct
%     |---name
%     |---dims
%           |---name
%           |---length
%     |---atts
%           |---name
%           |---value
%     |---vars
%           |---name
%           |---type
%           |---dims
%           |---atts
%                 |---name
%                 |---value
% 
%
% output :
%   \
%
% Siqi Li, SMAST
% 2022-04-06
%
% Updates:
%
%==========================================================================
function nc_def_header0(nc0)

fin = nc0.name;

ncid = nc_create(fin);
nc_close(ncid);

% Define dimensions
for i = 1 : length(nc0.dims)
    nc_def_dim(fin, nc0.dims(i).name, nc0.dims(i).length);
end

% Define global attributes
if isfield(nc0, 'atts')
    for i = 1 : length(nc0.atts)
        nc_def_att(fin, [], nc0.atts(i).name, nc0.atts(i).value);
    end
end

% Define variables
for i = 1 : length(nc0.vars)
    nc_def_var(fin, nc0.vars(i).name, nc0.vars(i).type, nc0.vars(i).dims);
    if isfield(nc0.vars(i), 'atts')
        for j = 1 : length(nc0.vars(i).atts)
            nc_def_att(fin, nc0.vars(i).name, nc0.vars(i).atts(j).name, nc0.vars(i).atts(j).value);
        end
    end
end



end



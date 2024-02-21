%==========================================================================
% nc_ks    ---   nc_toolbox
%   Extract parts of NetCDF files (similar to the linux 'ncks')
%
% input  :
%   fin        --- input NetCDF file path and name
%   fout       --- output NetCDF file path and name
%   Variable   --- name list of variables to be extracted (string)
%   Dimension  --- information list of dimensions to be changed (string)
%   Overwrite  --- overwrite flag
%
% output :
%   \
%
% Example:
%   nc_ks(fin, fout, 'Variable', ["XLONG" "ZNU"], ...
%                    'Dimension', ["Time,2,3" "bottom_top,1"]);
%
% Siqi Li, SMAST
% 2023-03-15
%
% Updates:
%
%==========================================================================
function nc_extract(fin, fout, varargin)

varargin = read_varargin(varargin, {'Variable'}, {[]});
varargin = read_varargin(varargin, {'Dimension'}, {[]});
varargin = read_varargin2(varargin, {'Overwrite'});



if isempty(Variable) && isempty(Dimension)
    error('Neither variable nor dimension settings are set.')
end

% clc
% clear
% fin = '/hosts/hydra.smast.umassd.edu/data3/siqili/case/wrf_2017_merged_windfarm03/wrfout/input/wrfout_d03_20171231';
% fout = './test.nc';
% Dimension = ["Time,2,3" "bottom_top,1"];
% Variable = ["XLONG" "XLAT" "ZNU"];
% Overwrite = 'Overwrite';

if ~isempty(Overwrite)
    if exist(fout, 'file') == 2
        delete(fout);
    end
end

info = ncinfo(fin);
dimensions = info.Dimensions;
variables = info.Variables;

ndim = length(Dimension);
nvar = length(Variable);

for i = 1 : ndim
    tmp = split(Dimension{i}, ',');
    j = find(ismember({dimensions.Name},tmp{1}));
    if isempty(j)
        error(['Unknown dimension name: ' tmp{1}])
    end
    dim(i).name = tmp{1};
    dim(i).start = str2num(tmp{2});
    dim(i).end = dim(i).start;
    dim(i).stride = 1;
    if length(tmp) > 2
        dim(i(i)).end = str2num(tmp{3});
        if length(tmp) > 3
            dim(i(i)).stride = str2num(tmp{4});
        end
    end
end


for i = 1 : nvar
    j = find(ismember({variables.Name},Variable{i}));
    if isempty(j)
        error(['Unknown dimension name: ' Variable{i}])
    end
end
if isempty(Variable)
    Variable = convertCharsToStrings({variables.Name});
end



% Copy global attributes
nc_copy_att(fin, [], fout, []);


% Define dimensions.
for i = 1 : length(dimensions)
    name = dimensions(i).Name;
    if dimensions(i).Unlimited
        nc_def_dim(fout, name, 0);
    else
        j = find(ismember({dim.name}, name));
        if isempty(j)
            nc_def_dim(fout, name, dimensions(i).Length);
        else
            nc_def_dim(fout, name, length(dim(j).start:dim(j).stride:dim(j).end));
        end
    end
end




for i = 1 : length(Variable)

    iv = find(ismember({variables.Name},Variable{i}));
    name = variables(iv).Name;
    disp(['----' name])


    % Define variables
    if ~isempty(variables(iv).Dimensions)
        vardims = {variables(iv).Dimensions.Name};
        d = '';
        for j = 1 : length(vardims)
            k = find(ismember({dim.name}, vardims{j}));
            if isempty(k)
                d = [d ':'];
            else
                d = [d num2str(dim(k).start) ':' num2str(dim(k).stride) ':' num2str(dim(k).end)];
            end
            if j < length(vardims)
                d = [d ','];
            end
        end
        d = ['(' d ')'];
    else
        vardims = [];
        d = '';
    end
    nc_def_var(fout, name, variables(iv).Datatype, vardims);

    % Copy attributes
    nc_copy_att(fin, name, fout, name);

    % Read the data
    data = nc_get_var(fin, name);
    eval(['data = data' d ';']);

    % Write the data
    nc_put_var(fout, name, data);

end


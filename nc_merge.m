%==========================================================================
% nc_merge    ---   nc_toolbox
%   Merge NetCDF files (similar to ncrcat)
%
% input  :
%   fin        --- input NetCDF file path and name
%   fout       --- output NetCDF file path and name
%   Variable   --- name list of variables to be extracted (string)
%   Overwrite  --- overwrite flag
%
% output :
%   \
%
% Example:
%
% Siqi Li, SMAST
% 2023-03-15
%
% Updates:
%
%==========================================================================
function nc_merge(fins, fout, varargin)

varargin = read_varargin(varargin, {'Variable'}, {[]});
varargin = read_varargin2(varargin, {'Overwrite'});

% clc
% clear
% fins = ["/hosts/hydra.smast.umassd.edu/data3/siqili/case/wrf_2017_merged_windfarm03/wrfout/input/wrfout_d03_20171231"
%         "/hosts/hydra.smast.umassd.edu/data3/siqili/case/wrf_2017_merged_windfarm03/wrfout/input/wrfout_d03_20171225"];
% fout = './test.nc';
% Variable = ["XLONG" "XLAT" "ZNU"];
% Overwrite = 'Overwrite';

if ~isempty(Overwrite)
    if exist(fout, 'file') == 2
        delete(fout);
    end
else
    if exist(fout, 'file') == 2
        error('The output exists. Change another fout or use Overwrite.')
    end
end

fin = fins{1};

info = ncinfo(fin);
variables = info.Variables;
dimensions = info.Dimensions;

nvar = length(Variable);

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
        nc_def_dim(fout, name, dimensions(i).Length);
    end
end

% Variable
for j = 1 : length(fins)

    fin = fins{j};
    disp(['--' fin])
    for i = 1 : length(Variable)
        iv = find(ismember({variables.Name},Variable{i}));
        name = variables(iv).Name;

        if ~isempty(variables(iv).Dimensions)
            vardims = {variables(iv).Dimensions.Name};
            unlimited = [variables(iv).Dimensions.Unlimited];
        else
            vardims = [];
    	    unlimited = [];
        end

        if j == 1
            % Define variables
            nc_def_var(fout, name, variables(iv).Datatype, vardims);
            % Copy attributes
            nc_copy_att(fin, name, fout, name);

            % Write data for normal variables
            if ~any(unlimited)
                disp(['----' name])
                nc_copy_data(fin, name, fout, name)
            end
        end

        % Write data for vairbales with unlimited dimensions
        disp(['    ' name ' (merge)'])
        data = nc_get_var(fin, name);
        start = zeros(1, length(unlimited));
        start(unlimited) = j-1;
        count = [variables(iv).Dimensions.Length];
        count(unlimited) = 1;
        nc_put_var(fout, name, data, start, count);
    end

end


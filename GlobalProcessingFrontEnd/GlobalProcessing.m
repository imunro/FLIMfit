function GlobalProcessing(OMERO_active)


% Copyright (C) 2013 Imperial College London.
% All rights reserved.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
%
% This software tool was developed with support from the UK 
% Engineering and Physical Sciences Council 
% through  a studentship from the Institute of Chemical Biology 
% and The Wellcome Trust through a grant entitled 
% "The Open Microscopy Environment: Image Informatics for Biological Sciences" (Ref: 095931).

% Author : Sean Warren



addpath_global_analysis();

if nargin == 0 
    global_processing_ui();
else
    global_processing_ui(false, OMERO_active);
end

%{
debug_info = struct();

debug_info.computer = computer;
debug_info.os = getenv('OS');
debug_info.ver = ver;
debug_info.hostname = getenv('COMPUTERNAME');
debug_info.timestamp = datestr(now,'yyyy-mm-dd--HH-MM-SS');
debug_info.output = evalc('global_processing_ui(true);');


filename = ['DebugLog\' debug_info.hostname '-' debug_info.timestamp '.m'];
%}
%save(filename,'debug_info');
    
end

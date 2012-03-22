function g = GlobalProcessing(OMERO_active)

addpath_global_analysis();

if nargin == 0 
    g=global_processing_ui();
else
               
    g=global_processing_ui(OMERO_active);
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
save(filename,'debug_info');
%}
			
end

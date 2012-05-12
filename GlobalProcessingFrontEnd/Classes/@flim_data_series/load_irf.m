function load_irf(obj,file,load_as_image)

    if strcmp(obj.mode,'TCSPC')
        channel = obj.request_channels(obj.polarisation_resolved);
    else
        channel = 1;
    end

    if nargin < 3
        load_as_image = false;
    end
        
    [t_irf,irf_image_data] = load_flim_file(file,channel);    
    irf_image_data = double(irf_image_data);
    
    % Sum over pixels
    s = size(irf_image_data);
    if length(s) == 3
        irf = reshape(irf_image_data,[s(1) s(2)*s(3)]);
        irf = mean(irf,2);
    elseif length(s) == 4
        irf = reshape(irf_image_data,[s(1) s(2) s(3)*s(4)]);
        irf = mean(irf,3);
    else
        irf = irf_image_data;
    end
    
    % export may be in ns not ps.
    if max(t_irf) < 300
       t_irf = t_irf * 1000; 
    end
    
    if load_as_image
        irf_image_data = obj.smooth_flim_data(irf_image_data,7);
        obj.image_irf = irf_image_data;
        obj.has_image_irf = true;
    else
        obj.has_image_irf = false;
    end
    
    
    obj.t_irf = t_irf(:);
    obj.irf = irf;
    obj.irf_name = 'irf';

    obj.t_irf_min = min(obj.t_irf);
    obj.t_irf_max = max(obj.t_irf);
    
    obj.estimate_irf_background();
    
    obj.compute_tr_irf();
    obj.compute_tr_data();
    
    notify(obj,'data_updated');

    
end
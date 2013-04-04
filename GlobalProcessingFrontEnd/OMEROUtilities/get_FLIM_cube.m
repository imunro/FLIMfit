function data_cube = get_FLIM_cube( session, image, sizet , modulo, ZCT , verbose)

    % sizet  here is the size of the relative-time dimension(t)
    % ie the number of time-points/length(delays)
     %
    data_cube = [];
    %
    if ~strcmp(modulo,'ModuloAlongC') && ~strcmp(modulo,'ModuloAlongT') && ~strcmp(modulo,'ModuloAlongZ')
        [ST,I] = dbstack('-completenames');
        errordlg(['No acceptable ModuloAlong* in the function ' ST.name]);
        return;
    end;    
    
    
    pixelsList = image.copyPixels();    
    pixels = pixelsList.get(0);
    %
    sizeX = pixels.getSizeX().getValue();
    sizeY = pixels.getSizeY().getValue();
    %sizeC = pixels.getSizeC().getValue();
    %sizeT = pixels.getSizeT().getValue();
    %sizeZ = pixels.getSizeZ().getValue();
    %
    pixelsId = pixels.getId().getValue();
   
    
    
     % convert to java/c++ numbering from 0
    Zarr  = ZCT{1}-1;
    Carr = double(ZCT{2}-1);
    Tarr = ZCT{3}-1;
    
    
     nchans = length(Carr);
    
    if length(Zarr) > 1 || length(Tarr) > 1   ||  nchans > 2    % temporarily only allow C to be non-singular
        return;
    end
    
     
    barstep = (sizet * nchans) +1;        % default doesn't display a bar
    
    if verbose
    
        w = waitbar(0, 'Loading FLIMage....');
        drawnow;
        
        barstep = ceil((sizet * nchans)/16);
    end
    
   
    store = session.createRawPixelsStore(); 
    store.setPixelsId(pixelsId, false); 
    
    
    data_cube = zeros(sizet,nchans,sizeY,sizeX,1);
    
   
     
     
      % Cast the binary data into the appropriate format
    type = char(pixels.getPixelsType().getValue().getValue());
    if strcmp(type,'float')
         type = 'single';
    end
    
    Z = Zarr(1);
    T = Tarr(1);
    
    barctr = 0;
    
    
    for c = 1:nchans
        
         C = Carr(c);

         % set up target planes
         targetz = ones(1,sizet) .* Z;        %defaults
         targetc = ones(1,sizet) .* C;
         targett = ones(1,sizet) .* T;

         switch modulo
            case 'ModuloAlongZ'
                tt = Z .* sizet;
                targetz = tt:(tt + (sizet - 1));
            case 'ModuloAlongC' 
                tt = C .* sizet;
                targetc = tt:(tt + (sizet - 1));
            case 'ModuloAlongT' 
                tt = T .* sizet;
                targett = tt:(tt + (sizet - 1));
         end

           
          
         
         for t = 1:sizet
            
            rawPlane = store.getPlane(targetz(t) , targetc(t), targett(t) ); 
            
         
            %following 3 lines replace 'plane = toMatrix(rawPlane, pixels);'
            %for speed
            plane = typecast(rawPlane, type );
            plane = reshape(plane, sizeX, sizeY);
            plane  = swapbytes(plane);

            data_cube(t,c,:,:,1) = plane';
            barctr = barctr + 1;
            if barctr == barstep
                waitbar((t/sizet),w);
                barctr = 0;
                drawnow;
            end
            
             
         end % end for sizet
         
        
         
    end % end for nchans

     
  
  
    
    store.close();
    
    if verbose
        delete(w);
        drawnow;
    end

end


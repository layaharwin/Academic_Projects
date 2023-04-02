function matrixPlot( Matrix ) 
figure(1)
imagesc(Matrix)
%colormap(parula(5));

% Create strings from the R values
Tstring = num2str(Matrix(:),'%d'); 

% Remove any space padding
Tstring= strtrim(cellstr(Tstring));

% Create x and y coordinates for the strings
[x,y] = meshgrid(1:length(Matrix));

% Plot the strings
text(x(:),y(:),Tstring(:));

end


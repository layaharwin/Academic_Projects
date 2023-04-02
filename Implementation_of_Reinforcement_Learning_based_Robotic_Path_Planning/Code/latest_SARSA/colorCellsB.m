% COLORCELLSB.m - Color cells.
% 
% This code will color a certain cell or a vector of cells given its state.
%
% You can do with this code whatever you want. The main purpose is help
% people learning about this. Also, there is no warranty of any kind.
%
% Juan Miguel Valverde Martinez
% http://laid.delanover.com
%
% @param episode: state or vector of states that will be colored

function colorCellsB( episode )
    
    % I can avoid painting the same area removing repeated states
    episode = unique(episode); 
    totalTimes = length(episode);
    
    for i=1:totalTimes
        
        [x,y] = state2cells(episode(i));
        
        cell_h = annotation('ellipse');
        set(cell_h, 'units', 'pixels', 'position', [50+13+50*(y-1),21+13+50*(6-x),20,20],...
            'color', [1 0 0], 'facecolor', 'red', 'tag', 'tmpcell');
    end

end
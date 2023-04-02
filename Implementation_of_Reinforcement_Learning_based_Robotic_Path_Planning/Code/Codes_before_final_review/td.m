stx=input('prompt');%str2num(get(handles.startpointx,'String'));        %input('Enter the x coordinate of starting point');
sty=input('prompt');%str2num(get(handles.startpointy,'String'));        %input('Enter the y coordinate of starting point');
N=4;

switch (stx)
    case(0.5)
        switch(sty)
            case(0.5)
                i=8;              %initializing cell number
                px=0.5;py=0.5;    %initializing ploting starting point
            case(1.5)
                i=14;
                px=0.5;py=1.5;
            case(2.5)
                i=20;
                px=0.5;py=2.5;
            case(3.5)
                i=26;
                px=0.5;py=3.5;
        end
    case(1.5)
            switch(sty)
            case(0.5)
                i=9;
                px=1.5;py=0.5;
            case(1.5)
                i=15;
                px=1.5;py=1.5;
            case(2.5)
                i=21;
                px=1.5;py=2.5;
            case(3.5)
                i=27;
                px=1.5;py=3.5;
        end
    case(2.5)
            switch(sty)
            case(0.5)
                i=10;
                px=2.5;py=0.5;
            case(1.5)
                i=16;
                 px=2.5;py=1.5;
            case(2.5)
                i=22;
                 px=2.5;py=2.5;
            case(3.5)
                i=26;
                 px=2.5;py=3.5;
            end
    case(3.5)
            switch(sty)
            case(0.5)
                i=11;
                px=3.5;py=0.5;
            case(1.5)
                i=17;
                px=3.5;py=1.5;
            case(2.5)
                i=23;
                px=3.5;py=2.5;
            case(3.5)
                i=29;
                px=3.5;py=3.5;
        end
end 
i;

n= input('prompt');%str2num(get(handles.numberofobstacle,'String'));%input('Enter the number of obstcles in the grid');
X=0:4;
Y=0:4;
figure('Color',[0.8 0.8 0.8]);
  plot(X,Y,'c');
  set(gca,'Color','c')
  xlabel('Distance covered along x-direcction')
ylabel('Distance covered along y-direcction')
grid on
hold on
set(gca,'XTick',[0 1 2 3 4],'YTick',[0 1 2 3 4]);
plot(stx,sty,'o');
hold on
%Initializing utility factors for each cell
%Modified utility factors for each cell's each arrival from other cell like diagonal
%right,horizontal right, vertical down, horizontal left,vertically up +
%Reward function

q1=[50 30 60 60 40];
q2=[50 80 60 60 40];
q3=[50 80 60 60 40];
q4=[50 80 60 10 40];
q5=[50 30 60 60 90];
q6=[150 130 110 110 140];
q7=[150 130 110 110 140];
q8=[150 130 110 10 140];
q9=[50 30 60 60 90];
q10=[150 130 110 110 140];
q11=[250 230 210 210 240];
q12=[250 230 10 10 240];
q13=[50 30 10 60 90];
q14=[150 80 10 110 140];
q15=[250 230 10 10 240];
q16=[450 440 10 10  440];

 if (n>0)        % obstacle is present


     x(1)=input('prompt');%str2num(get(handles.obstacle1x,'String'));
     y(1)=input('prompt');%str2num(get(handles.obstacle1y,'String'));
     x(2)=input('prompt');%str2num(get(handles.obstacle2x,'String'));
     y(2)=input('prompt');%str2num(get(handles.obstacle2y,'String'));
     x(3)=input('prompt');%str2num(get(handles.obstacle3x,'String'));
     y(3)=input('prompt');%str2num(get(handles.obstacle3y,'String'));
     % Obstacle plotting and Weight updation
for k=1:n
%      x(k)=input(['Enter the x coordinate of ' num2str(k) ' th obstacle']);
%      y(k)=input(['Enter the y coordinate of ' num2str(k) ' th obstacle']);
    
     plot(x(k),y(k),'-*','MarkerSize',12);
     
     hold on
     x(k)=ceil(x(k));
      y(k)=ceil(y(k));
switch (x(k))          % Updating the Modified utility factor based on the obstacle position
    case (1)
        switch(y(k))
            case(1)
                 q1=[0 0 0 0 0];
            case(2)
                 q5=[0 0 0 0 0];
            case(3)
                 q9=[0 0 0 0 0];
            case(4)
                q13=[0 0 0 0 0];
        end
    case (2)
         switch(y(k))
            case(1)
                 q2=[0 0 0 0 0];
            case(2)
                 q6=[0 0 0 0 0];
            case(3)
                 q10=[0 0 0 0 0];
            case(4)
                q14=[0 0 0 0 0];
        end
    case(3)
         switch(y(k))
            case(1)
                 q3=[0 0 0 0 0];
            case(2)
                 q7=[0 0 0 0 0];
            case(3)
                 q11=[0 0 0 0 0];
            case(4)
                q15=[0 0 0 0 0];
        end
    case(4)
        switch(y(k))
            case(1)
                 q4=[0 0 0 0 0];
            case(2)
                 q8=[0 0 0 0 0];
            case(3)
                 q12=[0 0 0 0 0];
            case(4)
                q16=[0 0 0 0 0];
        end
end
end
q17=[0 0 0 0 0];
q18=[0 0 0 0 0];
q19=[0 0 0 0 0];
q20=[0 0 0 0 0];
s1=[0 0 10 10 0];s2=[0 30 10 10 0];s3=[0 30 10 10 0];s4=[0 30 10 10 0];s5=[0 30 10 10 0];
s6=[0 30 10 0 0];s7=[0 0 10 10 40];s8=[50 30 10 0 40];s9=[0 0 10 10 40];s10=[50 30 10 0 40];
s11=[0 0 10 10 40];s12=[50 30 10 0 40];s13=[0 0 10 10 40];s14=[50 30 10 0 40];s15=[0 0 10 10 40];
s16=[50 30 0 0 40];
q=[s1;s2;s3;s4;s5;s6;s7;q1;q2;q3;q4;s8;s9;q5;q6;q7;q8;s10;s11;q9;q10;q11;q12;s12;s13;q13;q14;q15;q16;s14;s15;q17;q18;q1;q20;s16];

 
      px=0.5;py=0.5;  %initiating ploting start point
    
     % i=8;
             
%        while ((mod(px,3.5)) | (mod(py,3.5)))
%           while (~(i==16))
tic
while(i~=29)
   if (q((i+7),(1))>q((i+6),(5)))          %diagonal>vertical
      if (q((i+7),(1))>q((i+1),(2)))           % diagonal> horizontal
         if  (q((i+7),(1))>q((i-1),(4)))  %i-1   %diagonal>horizontal bwd 
            if (q((i+7),(1))>q((i-6),(3)))%diagonal>vertical bwd  
          
                 x1=[(px),(px+1)];         %Diagonal movement
                 y1=[(py),(py+1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py+1;
                 i=i+7;

                      
            else %vertical bwd >diagonal & diagonal>horizontal bwd & diagonal>horizontal & diagonal>vertical
                 x1=[(px),(px)];         %vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6;                                            
            end
        else % horizontal bwd > diagonal & diagonal>horizontal & diagonal>vertical
            if  (q((i-1),(4))>q((i-6),(3))) %horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                i=i-1;
            else  
                 x1=[(px),(px)];         %vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6;    
            end
         end
    else % horizontal > diagonal & diagonal>vertical
        if (q((i+1),(2))>q((i-1),(4))) %horizontal > horizontal bwd
            if (q((i+1),(2))>q((i-6),(3))) %horizontal > vertical bwd
                 x1=[(px),(px+1)];         %Horizontal movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py;
                i=i+1; 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6;   
            end
        else % horizontal bwd > horizontal & horizontal > diagonal & diagonal>vertical
            if (q((i-1),(4))>q((i-6),(3))) % horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1; 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6; 
            end
        end
      end
             
else % Vertical> Diagonal
    if (q((i+6),(5))>q((i+1),(2)))  %vertical > horizontal
        if(q((i+6),(5))>q((i+1),(4))) %i-1% vertical > horizontal bwd
            if (q((i+6),(5))<q((i-6),(3))) % vertical > vertical bwd 
                 y1=[(py),(py+1)];       %Vertical movement
                 x1=[(px),(px)]; 
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py+1;
                 i=i+6; 
            else % vertical bwd > vertical & vertical > horizontal bwd & vertical > horizontal & Vertical> Diagonal
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6; 
            end
        else % horizontal bwd > vertical & vertical > horizontal & Vertical> Diagonal
            if (q((i-1),(4))>q((i-6),(3))) % horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1; 
            else
                x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6;
            end
        end
                
    else   % horizontal >vertical & Vertical> Diagonal
        if (q((i+1),(2))>q((i-1),(4))) %horizontal > horizontal bwd
            if (q((i+1),(2))>q((i-6),(3))) %horizontal > vertical bwd
                 x1=[(px),(px+1)];         %Horizontal movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py;
                 i=i+1;
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6; 
            end 
        else % horizontal bwd > horizontal & horizontal >vertical & Vertical> Diagonal
            if (q((i-1),(4))>q((i-6),(3))) %horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1;
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-6; 
            end
        end
    end
   end
end 
toc
%  axes(handles.axes1);     % To show the image 
  %imshow(image); 
 
 %guidata(hObject,handles); 
 % handles=guidata(hObject);
 
 DirectoryPath ='C:\Users\hp\Desktop\MAIN_PRO\codes';
 whereToStore=fullfile(DirectoryPath,['Figure.png']);
 saveas(gcf, whereToStore);
     axes(handles.axes1);  
    imshow('C:\Users\hp\Desktop\MAIN_PRO\codes\Figure.png'); 
 
else 
     X=stx:N-0.5;
     Y=sty:N-0.5;
     plot(X,Y,'LineWidth',4);
    
     DirectoryPath ='C:\Users\hp\Desktop\MAIN_PRO\codes';%F:\amrita\Main project\Lab\MyMatlabExpts\basics\TD_GUI';
 whereToStore=fullfile(DirectoryPath,['Figure.png']);
 saveas(gcf, whereToStore);
     axes(handles.axes1);  
    imshow('C:\Users\hp\Desktop\MAIN_PRO\codes\Figure.png'); 
  %  guidata(hObject,handles); 
  %        axes(handles.axes1);     % To show the image
    imshow(image)
 
 end 
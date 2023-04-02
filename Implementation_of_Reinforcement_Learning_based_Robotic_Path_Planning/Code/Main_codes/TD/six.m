%%PROJECT TOPIC: IMPLEMENTATION OF REINFORCEMENT LEARNING BASED ROBOTIC PATH PLANNING 
%%TD ALGORITHM FOR 6X6 GRID

stx= input('Enter the x coordinate of starting point');
sty=input('Enter the y coordinate of starting point');
N=6;

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
            case(4.5)
                i=32;
                px=0.5;py=4.5;
            case(4.5)
                i=38;
                px=0.5;py=5.5;
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
            case(4.5)
                i=33;
                px=1.5;py=4.5;
            case(5.5)
                i=39;
                px=1.5;py=5.5;
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
                i=28;
                 px=2.5;py=3.5;
           case(4.5)
               i=34;
               px=2.5;py=4.5;
           case(4.5)
               i=40;
               px=2.5;py=5.5;
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
            case(4.5)
                i=35;
                px=3.5;py=4.5;
            case(5.5)
                i=41;
                px=3.5;py=5.5;
            end
      case(4.5)
            switch(sty)
            case(0.5)
                i=12;
                px=4.5;py=0.5;
            case(1.5)
                i=18;
                px=4.5;py=1.5;
            case(2.5)
                i=24;
                px=4.5;py=2.5;
            case(3.5)
                i=30;
                px=4.5;py=3.5;
            case(4.5)
                i=36;
                px=4.5;py=4.5;
            case(5.5)
                i=42;
                px=4.5;py=5.5;
            end
   case(5.5)
            switch(sty)
            case(0.5)
                i=13;
                px=5.5;py=0.5;
            case(1.5)
                i=19;
                px=5.5;py=1.5;
            case(2.5)
                i=25;
                px=5.5;py=2.5;
            case(3.5)
                i=31;
                px=5.5;py=3.5;
            case(4.5)
                i=37;
                px=5.5;py=4.5;
            case(5.5)
                i=43;
                px=5.5;py=5.5;
            end
end 
i;

n= input('Enter the number of obstcles in the grid');
X=0:6;
Y=0:6;
figure('Color',[0.8 0.8 0.8]);
  plot(X,Y,'y');
  set(gca,'Color','y')
  xlabel('Distance covered along x-direcction')
ylabel('Distance covered along y-direcction')
grid on
hold on
set(gca,'XTick',[0 1 2 3 4 5 6],'YTick',[0 1 2 3 4 5 6]);
plot(stx,sty,'o');
hold on
%Initializing utility factors for each cell
%Modified utility factors for each cell's each arrival from other cell like diagonal
%right,horizontal right, vertical down, horizontal left,vertically up +
%Reward function

q1=[50 30 60 60 40];
q2=[50 80 60 60 40];
q3=[50 80 60 60 40];
q4=[50 80 60 60 40];
q5=[50 80 60 60 40];
q6=[50 80 60 10 40];

q7=[50 30 60 60 90];
q8=[150 130 110 110 140];
q9=[150 130 110 110 140];
q10=[150 130 110 110 140];
q11=[150 130 110 110 140];
q12=[150 130 110 10 140];

q13=[50 30 60 60 90];
q14=[150 130 110 110 140];
q15=[250 230 210 210 240];
q16=[250 230 210 210 240];
q17=[250 230 210 210 240];
q18=[250 230 10 10 240];

q19=[50 30 60 60 90];
q20=[150 130 110 110 140];
q21=[250 230 210 210 240];
q22=[450 430 210 210 440];
q23=[450 430 210 210 440];
q24=[450 430 10 10 440];

q25=[50 30 10 60 90];
q26=[150 80 10 110 140];
q27=[250 230 210 210 240];
q28=[450 430 210 210 440];
q29=[550 530 310 310 540];
q30=[550 530 10 10 540];

q31=[50 30 10 60 90];
q32=[150 80 10 10 240];
q33=[250 230 10 10 240];
q34=[450 430 10 10 440];
q35=[550 530 10 10 540];
q36=[650 630 10 10 640];

 if (n>0)        % obstacle is present

     x(1)=input('Enter the x coordinate of the first obstcle:');
     y(1)=input('Enter the y coordinate of the first obstcle:');
     x(2)=input('Enter the x coordinate of the second obstcle:');
     y(2)=input('Enter the y coordinate of the second obstcle:');
     x(3)=input('Enter the x coordinate of the third obstcle:');
     y(3)=input('Enter the y coordinate of the third obstcle:');
     x(4)=input('Enter the x coordinate of the fourth obstcle:');
     y(4)=input('Enter the y coordinate of the fourth obstcle:');
     x(5)=input('Enter the x coordinate of the fifth obstcle:');
     y(5)=input('Enter the y coordinate of the fifth obstcle:');
     x(6)=input('Enter the x coordinate of the sixth obstcle:');
     y(6)=input('Enter the y coordinate of the sixth obstcle:');
    
     % Obstacle plotting and Weight updation
for k=1:n
%      x(k)=input(['Enter the x coordinate of ' num2str(k) ' th obstacle']);
%      y(k)=input(['Enter the y coordinate of ' num2str(k) ' th obstacle']);
    
     plot(x(k),y(k),'m s','MarkerSize',25,'LineWidth',10);
     
     hold on
     x(k)=ceil(x(k));
     y(k)=ceil(y(k));

switch (x(k))          % Updating the Modified utility factor based on the obstacle position
    case (1)
        switch(y(k))
            case(1)
                 q1=[0 0 0 0 0];
            case(2)
                 q7=[0 0 0 0 0];
            case(3)
                 q13=[0 0 0 0 0];
            case(4)
                q19=[0 0 0 0 0];
            case(5)
                q25=[0 0 0 0 0];
            case(5)
                q31=[0 0 0 0 0];
        end
    case (2)
         switch(y(k))
            case(1)
                 q2=[0 0 0 0 0];
            case(2)
                 q8=[0 0 0 0 0];
            case(3)
                 q14=[0 0 0 0 0];
            case(4)
                 q20=[0 0 0 0 0];
             case(5)
                 q26=[0 0 0 0 0];   
             case(6)
                 q32=[0 0 0 0 0];
         end
    case(3)
         switch(y(k))
            case(1)
                 q3=[0 0 0 0 0];
            case(2)
                 q9=[0 0 0 0 0];
            case(3)
                 q15=[0 0 0 0 0];
            case(4)
                q21=[0 0 0 0 0];
             case(5)
                 q27=[0 0 0 0 0];
             case(6)
                 q33=[0 0 0 0 0];
         end
    case(4)
        switch(y(k))
            case(1)
                 q4=[0 0 0 0 0];
            case(2)
                 q10=[0 0 0 0 0];
            case(3)
                 q16=[0 0 0 0 0];
            case(4)
                q22=[0 0 0 0 0];
            case(5)
                q28=[0 0 0 0 0];
             case(6)
                q34=[0 0 0 0 0];
        end
    case(5)
        switch(y(k))
            case(1)
                 q5=[0 0 0 0 0];
            case(2)
                 q11=[0 0 0 0 0];
            case(3)
                 q17=[0 0 0 0 0];
            case(4)
                q23=[0 0 0 0 0];
            case(5)
                q29=[0 0 0 0 0];
             case(6)
                 q35=[0 0 0 0 0];
        end
    case(6)
        switch(y(k))
            case(1)
                 q6=[0 0 0 0 0];
            case(2)
                 q12=[0 0 0 0 0];
            case(3)
                 q18=[0 0 0 0 0];
            case(4)
                q24=[0 0 0 0 0];
            case(5)
                q30=[0 0 0 0 0];
             case(6)
                 q36=[0 0 0 0 0];
        end
end
end
q37=[0 0 0 0 0];
q38=[0 0 0 0 0];
q39=[0 0 0 0 0];
q40=[0 0 0 0 0];
q41=[0 0 0 0 0];
q42=[0 0 0 0 0];
q43=[0 0 0 0 0];

s1=[0 0 10 10 0];s2=[0 30 10 10 0];s3=[0 30 10 10 0];s4=[0 30 10 10 0];s5=[0 30 10 10 0];
s6=[0 30 10 0 0];s7=[0 0 10 10 40];s8=[50 30 10 0 40];s9=[0 0 10 10 40];s10=[50 30 10 0 40];
s11=[0 0 10 10 40];s12=[50 30 10 0 40];s13=[0 0 10 10 40];s14=[50 30 10 0 40];s15=[0 0 10 10 40];
s16=[50 30 0 0 40];
q=[s1;s2;s3;s4;s5;s6;s7;q1;q2;q3;q4;q5;q6;s9;q7;q8;q9;q10;q11;q12;s10;q13;q14;q15;q16;q17;q18;s11;q19;q20;q21;q22;q23;q24;s12;q25;q26;q27;q28;q29;q30;s13;q31;q32;q33;q34;q35;q36;s14;q37;q38;q39;q40;q41;q42;s15];

tic
while(i~=43)
   if (q((i+8),(1))>q((i+7),(5)))          %diagonal>vertical
      if (q((i+8),(1))>q((i+1),(2)))           % diagonal> horizontal
         if  (q((i+8),(1))>q((i-1),(4)))     %diagonal>horizontal bwd 
            if (q((i+8),(1))>q((i-7),(3)))%diagonal>vertical bwd  
          
                 x1=[(px),(px+1)];         %Diagonal movement
                 y1=[(py),(py+1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py+1;
                 i=i+8;
if (i>47)
    break;
end    
                      
            else %vertical bwd >diagonal & diagonal>horizontal bwd & diagonal>horizontal & diagonal>vertical
                 x1=[(px),(px)];         %vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7; 
                 if (i>47)
                   break;
                 end 
            end
        else % horizontal bwd > diagonal & diagonal>horizontal & diagonal>vertical
            if  (q((i-1),(4))>q((i-7),(3))) %horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                i=i-1;
                if (i>47)
                  break;
                end 
            else  
                 x1=[(px),(px)];         %vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7;    
                 if (i>47)
                     break;
                 end 
            end
         end
    else % horizontal > diagonal & diagonal>vertical
        if (q((i+1),(2))>q((i-1),(4))) %horizontal > horizontal bwd
            if (q((i+1),(2))>q((i-7),(3))) %horizontal > vertical bwd
                 x1=[(px),(px+1)];         %Horizontal movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py;
                i=i+1; 
                if (i>47)
                   break;
                end 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7;   
                 if (i>47)
                     break;
                 end 
            end
        else % horizontal bwd > horizontal & horizontal > diagonal & diagonal>vertical
            if (q((i-1),(4))>q((i-7),(3))) % horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1;
                 if (i>47)
                       break;
                 end 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7; 
                 if (i>47)
                    break;
                end 
            end
        end
      end
             
else % Vertical> Diagonal
    if (q((i+7),(5))>q((i+1),(2)))  %vertical > horizontal
        if(q((i+7),(5))>q((i-1),(4))) % vertical > horizontal bwd
            if (q((i+7),(5))>q((i-7),(3))) % vertical > vertical bwd 
                 y1=[(py),(py+1)];       %Vertical movement
                 x1=[(px),(px)]; 
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py+1;
                 i=i+7; 
                 if (i>47)
                    break;
                 end 
            else % vertical bwd > vertical & vertical > horizontal bwd & vertical > horizontal & Vertical> Diagonal
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7; 
                 if (i>47)
                       break;
                 end 
            end
        else % horizontal bwd > vertical & vertical > horizontal & Vertical> Diagonal
            if (q((i-1),(4))>q((i-7),(3))) % horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1; 
                 if (i>47)
                     break;
                 end 
            else
                x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7;
                 if (i>47)
                   break;
                 end 
            end
        end
                
    else   % horizontal >vertical & Vertical> Diagonal
        if (q((i+1),(2))>q((i-1),(4))) %horizontal > horizontal bwd
            if (q((i+1),(2))>q((i-7),(3))) %horizontal > vertical bwd
                 x1=[(px),(px+1)];         %Horizontal movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px+1;
                 py=py;
                 i=i+1;
                 if (i>47)
                    break;
                 end 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7; 
                 if (i>47)
                    break;
                 end 
            end 
        else % horizontal bwd > horizontal & horizontal >vertical & Vertical> Diagonal
            if (q((i-1),(4))>q((i-7),(3))) %horizontal bwd > vertical bwd
                 x1=[(px),(px-1)];         %Horizontal bwd movement
                 y1=[(py),(py)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px-1;
                 py=py;
                 i=i-1;
                 if (i>47)
                    break;
                 end 
            else
                 x1=[(px),(px)];        % Vertical bwd movement
                 y1=[(py),(py-1)];
                 plot(x1,y1,'k','LineWidth',4);
                 
                 hold on
                 px=px;
                 py=py-1;
                 i=i-7;
                 if (i>47)
                    break;
                  end 
            end
        end
    end
   end
end 
toc

 else 
  
     X=stx:N-0.5;
     Y=sty:N-0.5;
     plot(X,Y,'k','LineWidth',4);
 
 end 

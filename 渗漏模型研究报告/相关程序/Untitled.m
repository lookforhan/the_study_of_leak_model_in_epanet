 a=[1;2;3;4;5;6;7;8;11;11;11;12];
 b = zeros(12,1);b(1:3)=1;
 c = 1:12;
 d=[a,b,c'];
 e = zeros (24,2);
 for i = 1:3
     d1 = d(:,i);
     d2 = repmat(d1',2,1);
     d3 = d2(:);
     e(:,i) = d3;
 end
 c1 = e(:,3);
 c2 = [0;c1(1:23)];
 plot(c2,e(:,1));
 hold on
 plot(c2,e(:,2));
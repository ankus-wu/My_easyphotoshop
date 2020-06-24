a=input('输入\n','s');
i=imread(a);
I=rgb2gray(i);
bw=im2bw(I);
figure(1)
imshow(I)

[n1,n2]=size(bw);
r=floor(n1/10);
c=floor(n2/10);
x1=1;x2=r;
s=r*c;

for m=1:10
    y1=1;y2=c;
    for j=1:10
        if(y2<=c||y2>=9*c)||(x1==1||x2==r*10)
            loc=find(bw(x1:x2,y1:y2)==0);
            [o ,p]=size(loc);
            pr =o*100/s;
            if pr<=100
                bw(x1:x2,y1:y2)=0;
                r1=x1;r2=x2;s1=y1;s2=y2;
                pr1=0;
            end
            imshow(bw);
        end
        y1=y1+c;
        y2=y2+c;
    end
    x1=x1+r;
    x2=x2+r;
end
figure(2)
subplot(1,2,1);
imshow(bw);
title('二值化');

L=bwlabel(bw,8);
bb=regionprops(L,'BoundingBox');
bb1=struct2cell(bb);
bb2=cell2mat(bb1);

[s1, s2]=size(bb2);
mx=0;
for k=3:4:s2-1
    p=bb2(1,k)*bb2(1,k+1);
    if p>mx&&(bb2(1,k)/bb2(1,k+1))<1.8
        mx=p;
        j=k;
    end
end
subplot(1,2,2);
imshow(I);
title('人脸识别');

hold on;
rectangle('Position',[bb2(1,j-2),bb2(1,j-1),bb2(1,j),bb2(1,j+1)],'EdgeColor','r')

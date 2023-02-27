%arr = L;%[1 1 2 2; 1 1 2 2; 3 3 4 4; 3 3 4 4]
function arr=onewaymg(arr,BW_)
unique_values = unique(arr);
list_ = [];

for i = 1:length(unique_values)
    [x, y] = find(arr == unique_values(i));
    locations = [x, y];
    %for j=1:length(locations)
    %end

    center_of_mass = mean(locations);

    new_element = [center_of_mass(1) center_of_mass(2)];
    list_ = vertcat(list_, new_element);

    fprintf('Center of mass for %d: (%.2f, %.2f)\n', unique_values(i), center_of_mass(1), center_of_mass(2));
end

%disp(list_);
output = []; % Initialize the output array

for i = 1:length(list_)
    myself = list_(i,:);
    result=[];
    for j = 1:length(list_)

        if j ~= i % Avoid concatenating an item with itself
            tmp = list_(j ,:);

            p1 = myself;
            p2 = tmp;

            delta = p2 - p1;
            angle = atan2(delta(2), delta(1)) * 180/pi;

            %disp(angle);
            result =[result angle]; % Concatenate the two items
        else
            result =[result inf];
        end

    end
    output = [output ; result]; % Append the result to the output array
end

%disp(output); % Display the output array

% Define the input matrix
var1 = output;%[1 2 3; 4 5 6; 7 8 9]

% Find the row and column indices of values between 3 and 5
[row_idx, col_idx] = find((var1 >= 70 & var1 <= 110) | (var1 >= -110 & var1 <= -70));

% Convert the row and column indices to (x,y) coordinates
[x, y] = meshgrid(1:size(var1, 2), 1:size(var1, 1));
x_values = x(sub2ind(size(var1), row_idx, col_idx));
y_values = y(sub2ind(size(var1), row_idx, col_idx));

% Print the (x,y) coordinates
disp('Coordinates of values between +-70 and +-110:');
%disp([x_values(:), y_values(:)]);
var1 = [x_values(:), y_values(:)];%[1 7; 2 8; 3 6];
[~, idx] = sort(var1(:, 2), 'descend');
var2 = [var1(idx, 2), var1(idx, 1)];
disp(var2);

btwx=[];
btwy=[];
for bwt=1:length(BW_)
    btx=BW_(bwt,:);
    for bxi=1:length(btx)
        if BW_(bwt,bxi)==1
            btwx=[btwx bxi];
            btwy=[btwy bwt];
            %scatter(bxi, bwt, 10, "yellow", 'filled');
        end
    end
end

% read the image
img =uint8(255 * mat2gray(arr));% outputImage;

% generate random x and y coordinates for the dots
x = list_(:,1);
y = list_(:,2);

% display the image
imshow(img);

% hold the current figure
hold on;

% plot the dots
scatter(y, x, 10, 'r', 'filled');
text(y, x, cellstr(num2str((1:length(x))')));
for kk=1:length(var2)
    tmplinet='b-';
    if mod(kk,5) == 0
        % 如果 kk 能被 5 整除
        tmplinet='g-';
    elseif mod(kk,5) == 1
        % 如果 kk 除以 5 余数为 1
        tmplinet='r-';
    elseif mod(kk,5) == 2
        % 如果 kk 除以 5 余数为 1
        tmplinet='r-';
    elseif mod(kk,5) == 3
        tmplinet='g-';
        % 如果 kk 除以 5 余数为 1
    elseif mod(kk,5) == 4
        tmplinet='b-';
        % 如果 kk 除以 5 余数为 4
    else
        tmplinet='r-';
        % 如果 kk 除以 5 余数不是 0、1 或 4
    end

    ps=plot(cat(1,list_(var2(kk,1),2), list_(var2(kk,2),2)),cat(1,list_(var2(kk,1),1), list_(var2(kk,2),1)), tmplinet, 'LineWidth', 2);

    % Define the two points
    point1 = [list_(var2(kk,1),2), list_(var2(kk,1),1)];
    point2 = [list_(var2(kk,2),2), list_(var2(kk,2),1)];

    % Calculate the midpoint
    midpoint = (point1 + point2) / 2;
    coefficients = polyfit([point1(1), point2(1)], [point1(2), point2(2)], 1);

    % Display the result
    %disp(midpoint);
    %text(midpoint(1), midpoint(2), "y=("+coefficients(1)+")x+("+coefficients(2)+")");
    ovov=point1(1):point2(1);
    vcx=(ovov.*coefficients(1))+coefficients(2);
    %scatter(ovov, vcx, 10, "yellow", 'filled');
    if length(ovov)<=0
        fprintf("X?X");
    else
        rv1=round(ovov);
        rv2=round(vcx);
        %[iqx  iqy]=intersections(ovov,vcx,btwx,btwy);
        %text(iqx, iqy, num2str(kk));
        prevx=inf;
        prevy=inf;
        countbx=0;
        for intx=1:length(rv1)
            if rv2(intx)<=length(BW_(:,1))&&rv1(intx)<=length(BW_(1,:))&&BW_(rv2(intx),rv1(intx))==1
                if abs(prevx-rv1(intx))~=1 && abs(prevy-rv2(intx))~=1
                    text(rv1(intx), rv2(intx), 'X');
                    countbx=countbx+1;
                end
                prevx= rv1(intx);
                prevy=rv2(intx);
            end
        end
        if countbx==1
            text(midpoint(1), midpoint(2), "<"+var2(kk,1)+">"+"<"+var2(kk,2)+">");
            arr(arr==var2(kk,1))=var2(kk,2);
            % arr(L==var2(pp,2))=varint;
        else
            text(midpoint(1), midpoint(2), "O");
        end
    end

end


%imshow(imoverlay(A,BW_,'cyan'),'InitialMagnification',67)
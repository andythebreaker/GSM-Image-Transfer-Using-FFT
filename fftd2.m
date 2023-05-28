function y=fftd2(x)
define_setting='use_home_made_ftt';
tmp=zeros(size(x));
for j=1:1:length(x(:,1))
   
    if strcmp(define_setting,'use_home_made_ftt')
        need2transpose=x(j,:);
        tmp(j,:)=fftp3(need2transpose');
    else
        tmp(j,:)=fftp3(x(j,:));
    end

end
tp=zeros(size(tmp));
for j=1:1:length(tmp(1,:))

    if strcmp(define_setting,'use_home_made_ftt')
        need2transpose=tmp(:,j);
        tp(:,j)=fftp3(need2transpose);
    else
tp(:,j)=fftp3(tmp(:,j));
    end
end
y=tp;
end
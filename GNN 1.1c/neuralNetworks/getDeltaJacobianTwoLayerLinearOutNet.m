function [gradient,dInputs]=getDeltaJacobianTwoLayerLinearOutNet(net,netState,delta,jacNodes)
exampleNum=size(netState.inputs,2);
outNum=size(delta,1);

hiddenFirstDer=1-netState.hiddens.*netState.hiddens;
hiddenSecondDer=-2*netState.hiddens .* (1-netState.hiddens.*netState.hiddens);

for i=1:exampleNum
    hn(:,i)=(hiddenFirstDer(:,i) .* net.weights1(:,jacNodes(i)));
end
gradient.weights2=delta*hn';
gradient.bias2=zeros(outNum,1);
for i=1:exampleNum
    hn2(:,i)= hiddenSecondDer(:,i) .*net.weights1(:,jacNodes(i));
end
dnetf1=(net.weights2'*delta) .* hn2;
df2=(net.weights2'*delta) .* hiddenFirstDer ;
gradient.weights1=dnetf1 * netState.inputs';
for i=1:exampleNum
    gradient.weights1(:,jacNodes(i))=gradient.weights1(:,jacNodes(i))+df2(:,i);
end
gradient.bias1=sum(dnetf1,2);   %sum(dnetf1')'




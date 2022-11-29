\\======================================================================
\\ Script used to compute the curves needed in Thm 3.6

\\======================================================================
\\ Function to determine whether the value b is of the form p*a^3 or not.

IsGood(n)=
{local(a,b);
a=factor(n);
b=1;
for(i=1,matsize(a)[1],if(a[i,2]%3==0,b=b*a[i,1]^a[i,2]));
isprime(abs(n/b))
}

\\======================================================================
\\ Same but outputs the values a, p.
GoodDecomposition(n)=
{local(a,b);
a=factor(n);
b=1;
for(i=1,matsize(a)[1],if(a[i,2]%3==0,b=b*a[i,1]^a[i,2]));
abs(n/b)
}

\\======================================================================
\\ Main script. Sign1 is the sign of the right hand side, while sign2
\\ is the sign of b.

FindCurves(sign1,sign2)=
{local(cand,c,A,p,K,E,a,b);
cand=[];

/* First case, when b is positive and the right hand side is also positive
c will denote the value of the right hand side */

for(r=2,16,
    for(q=2,13,
        c=sign1*2^r*3^q;
	fordiv(c,b,b=sign2*b;A=c/b^3-27*b;
	    if(c%b^3==0 && IsGood(A),
	        p=GoodDecomposition(A);
		a=sign(A)*sqrtnint(abs(A/p),3);
		K=bnfinit(x^2+p);
		E=ellinit([a*x,0,b*x,0,0],K);
		if(p%24==19&&IsAdditive(E,K,2)&&IsAdditive(E,K,3),
		    cand=concat(cand,[[a,b,p,c]]))))));
cand}
	    

\\======================================================================
\\ Stupid routine to determine whether the local type has additive reduction.

IsAdditive(E,K,p)=elllocalred(E,idealprimedec(K,p)[1])[1]>=2.

\\======================================================================
\\ Usage:

\\ ? read("Code.gp");
\\ ? FindCurves(1,1)
\\ %2 = []
\\ ? FindCurves(1,-1)
\\ %3 = []
\\ ? FindCurves(-1,1)
\\ %4 = [[-6, 2, 547, -944784], [-12, 16, 547, -3869835264]]
\\ ? FindCurves(-1,-1)
\\ %5 = [[6, -2, 547, -944784], [12, -16, 547, -3869835264]]
\\ 




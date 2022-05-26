from scipy.stats import entropy

def JSD(p, q):
    P,Q=p[:],q[:]
    if len(P) > len(Q):
        minus_num=abs(len(P) - len(Q))
        Q+=[0]*minus_num
    elif len(P) < len(Q):
        minus_num=abs(len(Q) - len(P))
        P+=[0]*minus_num
    P=sorted(P)
    Q=sorted(Q)
    _P = P / norm(P, ord=1)
    _Q = Q / norm(Q, ord=1)
    _M = 0.5 * (_P + _Q)
    return round(0.5 * (entropy(_P, _M) + entropy(_Q, _M)),6)



def base_rate(ref_strains,answer_strains,original_alpha):
    k=len(original_alpha)
    error_base=0
    for i in reversed(range(len(original_alpha))):
        mini_mis=float('inf')
        for j in range(len(answer_strains)):
            mis_num=sum(abs(np.array(ref_strains[i])-np.array(answer_strains[j])))
            if mis_num < mini_mis:
                mini_mis=mis_num
        # error_base+=mini_mis*original_alpha[i]
        error_base+=mini_mis*(1.0/k)
    error_rate=round(float(error_base)/len(ref_strains[0]),6)
    # print (error_base, error_rate)
    return error_rate

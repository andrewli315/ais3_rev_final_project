#define BigInt uint64_t
 
//BigInt newBigInt(char *str) {
//  return atoi(str);
//}
 
char tempStr[1025];
 
//char *big2str(BigInt a) {
//  sprintf(tempStr, "%lld", a);
//  return tempStr;
//}
 
BigInt mul(BigInt a, BigInt b) {
  return a*b;
}
 
BigInt div(BigInt a, BigInt b) {
  return a/b;
}
 
BigInt mod(BigInt a, BigInt n) {
  return a%n;
}
 
BigInt inv(BigInt e, BigInt r) {
  BigInt d;
  for (d=2; d<r; d++) {
    BigInt ed = mul(e, d); // re = (e*d) % r;
    BigInt re = mod(ed,r);
    if (re == 1) {
//      printf("e=%lld d=%lld r=%lld (e*d) mod r=%lld\n", e, d, r, re);
      return d;
    }
  }
//  assert(0);
}
 
/*
BigInt power(BigInt a, BigInt k, BigInt N) {
  BigInt p=1, i;
  for (i=1; i<=k; i++) { 
    p = mul(p, a); // p = (p * a) % N;
    p = mod(p, N);
  }
  return p;
}
*/
 
BigInt power(BigInt a, BigInt k, BigInt N) {
  if (k =2
  BigInt k2 = div(k, 2);       // k2 = k / 2;
  BigInt re = mod(k, 2);       // re = k % 2;
  BigInt ak2= power(a, k2, N); // ak2 = a^(k/2);
  BigInt ak = mul(ak2, ak2);   // ak  = ak2*ak2 = a^((k/2)*2)
  BigInt akN= mod(ak, N);      // akN = ak % N
  if (re == 1) {               // if k is odd
    akN = mul(akN, a);         //   ak = ak*a;
    return mod(akN, N);        //   return ak * k;
  } else                       // else
    return akN;                //   return ak;
}
 
int main() {
  BigInt p = 2213, q = 2663;
  BigInt N = mul(p, q);
  BigInt r = mul(p-1, q-1);
//  printf("N=%s r=%s\n", big2str(N), big2str(r));
  BigInt e = 4723;
  BigInt d = inv(e, r);
  BigInt m = 3320;
//  printf("m=%s\n", big2str(m));
  BigInt c = power(m, e, N);
//  printf("c=%s\n", big2str(c));
  BigInt m2 = power(c, d, N);
//  printf("m2=%s\n", big2str(m2));
}
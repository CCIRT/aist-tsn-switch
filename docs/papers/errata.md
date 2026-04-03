### Erratum Notice

Unfortunately, we have discovered the presence of a couple of typos in the above published IEEE Access article.
We urge readers to pay attention to these typos and refer to the [Corrected version](IEEEAccess_June2024_Published_corrected.pdf) as they may compromise the correct understanding of our proposed approach. The discovered typos are summarized as follow:

**Page 5, Section IV.A:** 
> Physical Coding Sublayer (PCS) <br>

Must be corrected to:<br>

> Frame Check Sequence (FCS)

**Page 6, Algoithm 1:** 
> BucketFullTime = BucketEmptyTime **/** EmptyToFullDuration; <br>
> SchedulerEligibilityTime = BucketEmptyTime **/** LengthRecoveryDuration; <br>

Must be corrected to:<br>

> BucketFullTime = BucketEmptyTime **+** EmptyToFullDuration; <br>
> SchedulerEligibilityTime = BucketEmptyTime **+** LengthRecoveryDuration; 

**Page 7, End of Section IV-C-2:**
> In our prototype, ... the Input Ethernet frame embedded in the **Ethernet** Header, <br>

Must be corrected to:<br>

> In our prototype, ... the Input Ethernet frame embedded in the **IP** Header 

**Page 8, End of Section IV-E:**
> If EligibilityTime **<** (t), ... <br>
> EligibilityTime **≥** (t), ...

Must be corrected to:
> If  (t) **<** EligibilityTime, ... <br>
>  (t) **≥** EligibilityTime, ...

Εδώ γράφουμε σημειώσεις για το πλανο εργασίας και για την υλοποίηση της εργασιας.

Δηλαδή για τα επιμέρους βήματα. Επίσης παρατηρήσεις και ερωτήσεις που προκύπτουν, με αναφορά στα αρχεία που προκύπτουν οι ερωτήσεις.



- 29/04: 
- 
- Question1.scd(ερώτηση για την δημιουργία έξτρα παραμέτρων ελέγχου σε UGens)
- Composition Tree.txt(σκελετός/μορφή των συνθέσεων)

-30/5:

- Πώς μπορώ να κάνω ένα Envelope διακριτών σημείων, μετα το τέλος του να επαναλάβει τον κύκλο των σταδίων του?
- Στην συγκεκριμένη περίπτωση χρησιμοποιώ ένα Envelope για να ελέγχω την φορά+ταχυτητα ανάγνωσης αρχείο(rate).
- Αρχείο: BufRd.ar

12/7:

- Ανάρτηση 2 αρχείων: waitForBoot.scd, Mist.scd
- Στο πρώτο αρχείο υπάχουν 2 γκρουπ κυματομορφών που φτιάχνω.Ένα γκρουπ για Osc.ar/VOsc.ar και ένα για Shaper.ar.
Αυτές τις κυματομορφές τις χρησιμοποιώ σε διάφορες συνθέσεις με Wavetables.

- Στο δεύτερο αρχείο παραθέτω ένα SynthDef(fmDef) στο οποίο κάνω frequency modulation. Χρησιμοποιώ Osc.ar τόσο στο βασικό(carrier) σήμα και στον modulator.
- Με βάση αυτό ως πηγή, βγάζω διάφορα Synths, τα οποία κατατάσσω σε Pbinds.5 τετοια μοτίβα (Pbinds) αποτελούν την σύνθεση "Mist".
- Μπορείτε στο ομώνυμο αρχείο να ακούσετε την μορφή που έχει ως τώρα.
- Αναμένω με ενδιαφέρον τα σχολια / παρατηρήσεις σας

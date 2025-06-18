(define-constant deposit-min u1000000) ;; 1 STX in microstacks

(define-map deposits principal uint) ;; user => amount
(define-data-var total-deposits uint u0)
(define-map rewards principal uint) ;; pending rewards
(define-data-var admin principal tx-sender)

(define-private (only-admin)
  (ok (asserts! (is-eq tx-sender (var-get admin)) (err u100))))

;; Deposit STX
(define-public (deposit)
  (let (
    (amount (stx-get-balance tx-sender))
    (prev (default-to u0 (map-get? deposits tx-sender)))
    (new-total (+ prev amount))
  )
    (begin
      (asserts! (>= amount deposit-min) (err u101))
      (map-set deposits tx-sender new-total)
      (var-set total-deposits (+ (var-get total-deposits) amount))
      (ok new-total)
    )
  )
)

;; Admin adds yield to be distributed
(define-public (add-yield)
  (let (
    (yield (stx-get-balance tx-sender))
  )
    (begin
      (try! (only-admin))
      ;; TODO: Replace with real distribution logic
      (map-set rewards tx-sender yield)
      (ok yield)
    )
  )
)

;; User claims reward
(define-public (claim-reward)
  (let (
    (reward (default-to u0 (map-get? rewards tx-sender)))
  )
    (begin
      (asserts! (> reward u0) (err u102))
      (map-set rewards tx-sender u0)
      (stx-transfer? reward contract-caller 'ST000000000000000000002AMW42H)
    )
  )
)

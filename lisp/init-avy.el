(when (require 'avy nil t)
  (setq avy-all-windows nil)
  (setq avy-dispatch-alist nil)
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?\; ?q ?w ?e ?r ?t ?y ?u ?i ?o ?p ?z ?x ?c ?v ?b ?n ?m ?, ?. ?/))
  (setq avy-subword-extra-word-chars nil)

  (global-set-key (kbd "C-M-;") 'avy-goto-word-1)
  (global-set-key (kbd "C-<dead-acute>") 'avy-goto-word-1)
  (global-set-key (kbd "C-M-:") 'avy-goto-char-in-line)
  )

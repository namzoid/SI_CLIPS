;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

; from auto example

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot show)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot acceptable-answers)
   (slot state (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deffacts startup
   (state-list))
   


;;; start rule
(defrule system-banner
  =>
  (assert (UI-state (show WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (acceptable-answers))))
  
                    

;;; questions
(defrule are-in-japan
  (logical (start))
  =>
  (assert (UI-state (show AreYouInJapan_q)
                    (relation-asserted in-japan)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule do-miss-meat
  (logical (in-japan No))
  =>
  (assert (UI-state (show DoYouMissMeat_q)
                    (relation-asserted miss-meat)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-it-summer
  (logical (miss-meat No))
  =>
  (assert (UI-state (show IsItSummer_q)
                    (relation-asserted is-summer)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-it-thanksgiving
  (logical (is-summer No))
  =>
  (assert (UI-state (show IsItThanksgiving_q)
                    (relation-asserted is-thanksgiving)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule smelling-pee
  (logical (is-thanksgiving No))
  =>
  (assert (UI-state (show DoYouMind_q)
                    (relation-asserted do-mind)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-halloween
  (logical (do-mind Yes))
  =>
  (assert (UI-state (show IsItHalloween_q)
                    (relation-asserted is-halloween)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-poor-eye
  (logical (is-halloween No))
  =>
  (assert (UI-state (show DoYouHave_q)
                    (relation-asserted is-poor-eyesight)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule are-doing-mexican-night
  (logical (is-poor-eyesight No))
  =>
  (assert (UI-state (show MexicanNight_q)
                    (relation-asserted is-mexican-night)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule are-in-deep-south
  (logical (is-mexican-night No))
  =>
  (assert (UI-state (show DeepSouth_q)
                    (relation-asserted is-deep-south)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-you-popeye
  (logical (is-deep-south No))
  =>
  (assert (UI-state (show AreYouPopeye_q)
                    (relation-asserted is-popeye)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-corona-in-cart
  (logical (is-popeye No))
  =>
  (assert (UI-state (show Corona_q)
                    (relation-asserted is-corona)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule trying-keep-doctor-away
  (logical (is-corona No))
  =>
  (assert (UI-state (show Doctor_q)
                    (relation-asserted is-keeping-doctor-away)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule will-blame-dog
  (logical (is-keeping-doctor-away No))
  =>
  (assert (UI-state (show Blame_q)
                    (relation-asserted is-blaming)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule are-a-chef
  (logical (is-blaming No))
  =>
  (assert (UI-state (show Chef_q)
                    (relation-asserted is-chef)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule do-like-dirt
  (logical (is-chef No))
  =>
  (assert (UI-state (show Dirt_q)
                    (relation-asserted is-dirt)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-like-mayo
  (logical (is-dirt No))
  =>
  (assert (UI-state (show Mayo_q)
                    (relation-asserted is-mayo)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule do-need-to-get-regular
  (logical (is-mayo No))
  =>
  (assert (UI-state (show Regular_q)
                    (relation-asserted is-regular)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-in-hawaii
  (logical (is-regular No))
  =>
  (assert (UI-state (show AreYouInHawaii_q)
                    (relation-asserted is-in-hawaii)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-you-simpson
  (logical (is-in-hawaii No))
  =>
  (assert (UI-state (show AreYouASimpson_q)
                    (relation-asserted is-simpson)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-trying-to-lose-sizes
  (logical (is-simpson No))
  =>
  (assert (UI-state (show AreYouTryingTo_q)
                    (relation-asserted is-trying-to-lose)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule is-yourmom-cooking
  (logical (is-trying-to-lose No))
  =>
  (assert (UI-state (show IsYourMomCooking_q)
                    (relation-asserted mom-cooking)
                    (state running)
                    (acceptable-answers Yes No)))
)



(defrule are-you-making-smoothie
  (logical (mom-cooking No))
  =>
  (assert (UI-state (show AreYouMakingASmoothie_q)
                    (relation-asserted is-smoothie)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule is-mom-good
  (logical (mom-cooking Yes))
  =>
  (assert (UI-state (show GoodMom_q)
                    (relation-asserted good-mom)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-you-own-juicer
  (logical (is-smoothie No))
  =>
  (assert (UI-state (show DoYouOwnAJuicer_q)
                    (relation-asserted is-owning-juicer)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-you-believe-in-hype
  (logical (is-owning-juicer No))
  =>
  (assert (UI-state (show DoYouBelieveTheHype_q)
                    (relation-asserted is-believing)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-you-ending-life
  (logical (is-believing No))
  =>
  (assert (UI-state (show AreYouNearingTheEndOfLife_q)
                    (relation-asserted is-nearing)
                    (state running)
                    (acceptable-answers Yes No)))
)

(defrule do-you-watch
  (logical (is-nearing No))
  =>
  (assert (UI-state (show DoYouWatchTheFoodNetwork_q)
                    (relation-asserted is-watching)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-need-snack
  (logical (is-watching No))
  =>
  (assert (UI-state (show DoYouNeedAQuickSnack_q)
                    (relation-asserted is-snack)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-u-with-date
  (logical (is-snack No))
  =>
  (assert (UI-state (show AreYouWithADate_q)
                    (relation-asserted is-date)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-you-know
  (logical (is-date No))
  =>
  (assert (UI-state (show DoYouKnowWhatTheseAre_q)
                    (relation-asserted dont-know)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-u-want-best-fruit
  (logical (dont-know No))
  =>
  (assert (UI-state (show DoYouWantTheBestFruit_q)
                    (relation-asserted want-fruit)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule do-u-want-best-vege
  (logical (want-fruit No))
  =>
  (assert (UI-state (show DoYouWantTheBestVege_q)
                    (relation-asserted want-vege)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-u-entre-youth
  (logical (want-vege No))
  =>
  (assert (UI-state (show AreYouEntrepreneuring_q)
                    (relation-asserted no-youth)
                    (state running)
                    (acceptable-answers Yes No)))
)


(defrule are-you-making-pasta-sauce
  (logical (no-youth No))
  =>
  (assert (UI-state (show AreYouMakingPasta_q)
                    (relation-asserted pasta-sauce)
                    (state running)
                    (acceptable-answers Yes No)))
)



;;; final answers
(defrule japan-conclusion
  (logical (in-japan Yes))
  =>
  (assert (UI-state (show Japan_res)
                    (state final)))
)

(defrule miss-meat-conclusion
  (logical (miss-meat Yes))
  =>
  (assert (UI-state (show MissMeat_res)
                    (state final)))
)

(defrule summer-conclusion
  (logical (is-summer Yes))
  =>
  (assert (UI-state (show Summer_res)
                    (state final)))
)

(defrule thanksgiving-conclusion
  (logical (is-thanksgiving Yes))
  =>
  (assert (UI-state (show Thanksgiving_res)
                    (state final)))
)


(defrule pee-conclusion
  (logical (do-mind No))
  =>
  (assert (UI-state (show Sulfur_res)
                    (state final)))
)

(defrule halloween-conclusion
  (logical (is-halloween Yes))
  =>
  (assert (UI-state (show Halloween_res)
                    (state final)))
)


(defrule poor-eyesight-conclusion
  (logical (is-poor-eyesight Yes))
  =>
  (assert (UI-state (show PoorEyesight_res)
                    (state final)))
)



(defrule mexican-night-conclusion
  (logical (is-mexican-night Yes))
  =>
  (assert (UI-state (show MexicanNight_res)
                    (state final)))
)


(defrule deep-south-conclusion
  (logical (is-deep-south Yes))
  =>
  (assert (UI-state (show deepSouth_res)
                    (state final)))
)

(defrule popeye-conclusion
  (logical (is-popeye Yes))
  =>
  (assert (UI-state (show Popeye_res)
                    (state final)))
)


(defrule corona-conclusion
  (logical (is-corona Yes))
  =>
  (assert (UI-state (show Corona_res)
                    (state final)))
)


(defrule doctor-conclusion
  (logical (is-keeping-doctor-away Yes))
  =>
  (assert (UI-state (show Doctor_away_res)
                    (state final)))
)


(defrule blame-conclusion
  (logical (is-blaming Yes))
  =>
  (assert (UI-state (show Dog_res)
                    (state final)))
)


(defrule chef-conclusion
  (logical (is-chef Yes))
  =>
  (assert (UI-state (show Chef_res)
                    (state final)))
)


(defrule dirt-conclusion
  (logical (is-dirt Yes))
  =>
  (assert (UI-state (show DirtTaste_res)
                    (state final)))
)


(defrule mayo-conclusion
  (logical (is-mayo Yes))
  =>
  (assert (UI-state (show Mayo_res)
                    (state final)))
)


(defrule mayo-conclusion
  (logical (is-mayo Yes))
  =>
  (assert (UI-state (show Mayo_res)
                    (state final)))
)


(defrule regular-conclusion
  (logical (is-regular Yes))
  =>
  (assert (UI-state (show regular_res)
                    (state final)))
)


(defrule hawaii-conclusion
  (logical (is-in-hawaii Yes))
  =>
  (assert (UI-state (show Hawaii_res)
                    (state final)))
)


(defrule simpson-conclusion
  (logical (is-simpson Yes))
  =>
  (assert (UI-state (show Simpson_res)
                    (state final)))
)


(defrule dress-conclusion
  (logical (is-trying-to-lose Yes))
  =>
  (assert (UI-state (show dressSize_res)
                    (state final)))
)


(defrule smoothie-conclusion
  (logical (is-smoothie Yes))
  =>
  (assert (UI-state (show Smoothie_res)
                    (state final)))
)


(defrule juicer-conclusion
  (logical (is-owning-juicer Yes))
  =>
  (assert (UI-state (show Juicer_res)
                    (state final)))
)


(defrule mom-cook-conclusion
  (logical (good-mom Yes))
  =>
  (assert (UI-state (show GoodMomYes_res)
                    (state final)))
)

(defrule mom-dont-cook-conclusion
  (logical (good-mom No))
  =>
  (assert (UI-state (show GoodMomNo_res)
                    (state final)))
)


(defrule hype-conclusion
  (logical (is-believing Yes))
  =>
  (assert (UI-state (show Juicer_res)
                    (state final)))
)


(defrule ending-life-conclusion
  (logical (is-nearing Yes))
  =>
  (assert (UI-state (show EndOfLife_res)
                    (state final)))
)


(defrule food-network-conclusion
  (logical (is-nearing Yes))
  =>
  (assert (UI-state (show FoodNetwork_res)
                    (state final)))
)


(defrule snack-conclusion
  (logical (is-snack Yes))
  =>
  (assert (UI-state (show QuickSnack_res)
                    (state final)))
)


(defrule date-conclusion
  (logical (is-date Yes))
  =>
  (assert (UI-state (show Date_res)
                    (state final)))
)


(defrule know-date-conclusion
  (logical (dont-know Yes))
  =>
  (assert (UI-state (show WhatAreDates_res)
                    (state final)))
)


(defrule best-fruit-conclusion
  (logical (want-fruit Yes))
  =>
  (assert (UI-state (show BestFruit_res)
                    (state final)))
)

(defrule best-vege-conclusion
  (logical (want-vege Yes))
  =>
  (assert (UI-state (show BestVege_res)
                    (state final)))
)

(defrule youth-conclusion
  (logical (no-youth Yes))
  =>
  (assert (UI-state (show Youth_res)
                    (state final)))
)


(defrule yes-sauce-conclusion
  (logical (pasta-sauce Yes))
  =>
  (assert (UI-state (show PastaYes_res)
                    (state final)))
)

(defrule no-sauce-conclusion
  (logical (pasta-sauce No))
  =>
  (assert (UI-state (show PastaNo_res)
                    (state final)))
)

;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question
   (declare (salience 5))
   (UI-state (id ?id))
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
   =>
   (modify ?f (current ?id) (sequence ?id ?s))
   (halt)
)

(defrule handle-next-no-change-none-middle-of-chain
   (declare (salience 10))
   ?f1 <- (next ?id)
   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt)
)

(defrule handle-next-response-none-end-of-chain
   (declare (salience 10))
   ?f <- (next ?id)
   (state-list (sequence ?id $?))
   (UI-state (id ?id) (relation-asserted ?relation))
   =>
   (retract ?f)
   (assert (add-response ?id))
)

(defrule handle-next-no-change-middle-of-chain
   (declare (salience 10))
   ?f1 <- (next ?id ?response)
   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   (UI-state (id ?id) (response ?response))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt)
)

(defrule handle-next-change-middle-of-chain
   (declare (salience 10))
   (next ?id ?response)
   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
   (UI-state (id ?id) (response ~?response))
   ?f2 <- (UI-state (id ?nid))
   =>
   (modify ?f1 (sequence ?b ?id ?e))
   (retract ?f2)
)

(defrule handle-next-response-end-of-chain
   (declare (salience 10))
   ?f1 <- (next ?id ?response)
   (state-list (sequence ?id $?))
   ?f2 <- (UI-state (id ?id) (response ?expected) (relation-asserted ?relation))
   =>
   (retract ?f1)
   (if (neq ?response ?expected) then (modify ?f2 (response ?response)))
   (assert (add-response ?id ?response)))

(defrule handle-add-response
   (declare (salience 10))
   (logical (UI-state (id ?id) (relation-asserted ?relation)))
   ?f1 <- (add-response ?id ?response)
   =>
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   (retract ?f1)
)

(defrule handle-add-response-none
   (declare (salience 10))
   (logical (UI-state (id ?id) (relation-asserted ?relation)))
   ?f1 <- (add-response ?id)
   =>
   (str-assert (str-cat "(" ?relation ")"))
   (retract ?f1)
)

(defrule handle-prev
   (declare (salience 10))
   ?f1 <- (prev ?id)
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
   =>
   (retract ?f1)
   (modify ?f2 (current ?p))
   (halt)
)




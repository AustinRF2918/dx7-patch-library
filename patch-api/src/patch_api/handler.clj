(ns patch-api.handler
  (:require [compojure.api.sweet :refer :all]
            [ring.util.http-response :refer :all]
            [ring.adapter.jetty :refer :all]
            [schema.core :as s]))

;;
;; Operator Utility, Request, Response Schemas
;;
(def OperatorBase
  {:envelope_generator_rate_1 s/Int
   :envelope_generator_rate_2 s/Int
   :envelope_generator_rate_3 s/Int
   :envelope_generator_rate_4 s/Int

   :envelope_generator_level_1 s/Int
   :envelope_generator_level_2 s/Int
   :envelope_generator_level_3 s/Int
   :envelope_generator_level_4 s/Int

   :level_scale_break_point s/Int
   :level_scale_left_depth s/Int
   :level_scale_right_depth s/Int

   :level_scale_left_curve (s/enum :negative_linear :negative_exponential :linear :exponential)
   :level_scale_right_curve (s/enum :negative_linear :negative_exponential :linear :exponential)

   :oscillator_rate_scale s/Int
   :amplitude_modulation_sense s/Int
   :key_velocity_sense s/Int

   :output_level s/Int
   :oscillator_mode (s/enum :ration :fixed)

   :course_frequency s/Int
   :fine_frequency s/Int
   :detune s/Int})
(s/defschema OperatorResponse (assoc OperatorBase :id s/Int))
(s/defschema OperatorRequest OperatorBase)

;;
;; Patch Utility, Request, Response Schemas
;;
(s/defschema PatchOperatorMapping
  {:operator_id s/Int
   :algorithm_position s/Int})

(def PatchBase
  {:pitch_rate_1 s/Int
   :pitch_rate_2 s/Int
   :pitch_rate_3 s/Int
   :pitch_rate_4 s/Int

   :pitch_level_1 s/Int
   :pitch_level_2 s/Int
   :pitch_level_3 s/Int
   :pitch_level_4 s/Int

   :feedback s/Int

   :osc_key_sync_enabled s/Bool

   :lfo_delay s/Int
   :lfo_amp_mod_depth s/Int
   :lfo_key_sync s/Bool

   :lfo_wave (s/enum :triangle :saw_down :saw_up :square :sine :sample_and_hold)

   :mod_sense_pitch s/Int
   :transpose s/Int

   :operators [PatchOperatorMapping]})
(s/defschema PatchRequest (assoc PatchBase :id s/Int))
(s/defschema PatchResponse PatchBase)

;;
;; Bank Utility, Request, Response Schemas
;;
(def BankBase
  {:name s/Str
   :patch_mapping {s/Int s/Int}})
(s/defschema BankRequest BankBase)
(s/defschema BankResponse (assoc BankBase :id s/Int))

;;
;; Application Request Handling
;;
(def app
  (api
    {:swagger
     {:ui "/"
      :spec "/swagger.json"
      :data {:info {:title "Patch API"
                    :description "API for creation and modification of DX7 patches."}}}}

    (context "/bank" []
      :tags ["Patch Bank API"]
      (GET "/:id" [id]
        :return BankResponse
        :summary "Gets a bank existing in the database"
        (ok {}))

      ;; TODO - Settle RESTful delete once and for all.
      (DELETE "/:id" [id]
        :return BankResponse
        :summary "Deletes a bank if possible. Does not perform cascading operations."
        (ok {}))

      (POST "/" []
        :return BankResponse
        :body [bank BankRequest]
        :summary "Allows creation of a patch bank"
        (ok {}))

      (PUT "/:id" [id]
        :return BankResponse
        :body [bank BankRequest]
        :summary "Allows updating of a patch bank"
        (ok {})))

    (context "/patch" []
      :tags ["Patch API"]
      (GET "/:id" [id]
        :return PatchResponse
        :summary "Gets a patch existing in the database"
        (ok {}))

      (DELETE "/:id" [id]
        :return PatchResponse
        :summary "Deletes a patch if possible. Does not perform cascading operations."
        (ok {}))

      (POST "/" []
        :return PatchResponse
        :body [patch PatchRequest]
        :summary "Allows creation of a patch"
        (ok {}))

      (PUT "/:id" [id]
        :return PatchResponse
        :body [patch PatchRequest]
        :summary "Allows updating of a patch"
        (ok {})))

    (context "/operator" []
      :tags ["Operator API"]

      (GET "/:id" [id]
        :return OperatorResponse
        :summary "Gets an operator existing in the database"
        (ok {}))

      (DELETE "/:id" [id]
        :return OperatorResponse
        :summary "Deletes an operator if possible. Does not perform cascading operations."
        (ok {}))

      (POST "/" []
        :return OperatorResponse
        :body [operator OperatorRequest]
        :summary "Allows creation of an operator"
        (ok {}))

      (PUT "/:id" [id]
        :return OperatorResponse
        :body [operator OperatorRequest]
        :summary "Allows updating of an operator"
        (ok {})))))

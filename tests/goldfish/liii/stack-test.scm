;
; Copyright (C) 2024 The Goldfish Scheme Authors
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
; http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
; WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
; License for the specific language governing permissions and limitations
; under the License.
;

(import (liii base) (liii lang) (liii stack) (liii check))

(check-set-mode! 'report-failed)

(check ((stack (list 1 2 3)) :length) => 3)

(check ((stack (list 1 2 3)) :size) => 3)

(check ((stack (list 1 2)) :top) => 1)
(check-catch 'out-of-range ((stack (list )) :top))

(check ((stack (list 1 2 3)) :to-list) => (list 1 2 3))
(check ((stack (list)) :to-list) => (list))

(check ((stack (list 1 2 3)) :to-rich-list) => ($ (list 1 2 3)))

(check ((stack :empty) :length) => 0)

(check ((stack (list 1 2)) :pop) => (stack (list 2)))
(check ((stack (list 1 2 3)) :pop :pop) => (stack (list 3)))
(check-catch 'out-of-range ((stack :empty) :pop))

(let1 t (stack (list 1 2 3))
  (check (t :pop!) => (stack (list 2 3)))
  (check (t :pop! :pop!) => (stack (list )))
  (check-catch 'out-of-range ((stack :empty) :pop!)))

(let1 t (stack (list 1 2 3))
  (check (t :push 1) => (stack (list 1 1 2 3)))
  (check (t :push 1 :push 1) => (stack (list 1 1 1 2 3))))

(let1 t (stack (list 1 2 3))
  (check (t :push! 1) => (stack (list 1 1 2 3)))
  (check (t :push! 1 :push! 1) => (stack (list 1 1 1 1 2 3)))
  (check (t :pop! :push! 2) => (stack (list 2 1 1 1 2 3))))

(check-report)


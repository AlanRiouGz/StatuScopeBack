-- Initial schema generated from the Quarkus 3.31.3 entity model.
-- Applied once to a NEW MySQL database; existing databases require a separate migration plan.
create table alerts (id varchar(36) not null, acknowledged_at datetime(6), created_at datetime(6) not null, message varchar(512), severity varchar(16) not null, outbreak_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table diagnoses (id varchar(36) not null, confidence decimal(5,2), created_at datetime(6) not null, notes tinytext, doctor_user_id varchar(36) not null, event_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table diagnosis_assistant_messages (id varchar(36) not null, created_at datetime(6) not null, message_text TEXT not null, role varchar(16) not null, sequence_no integer not null, thread_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table diagnosis_assistant_retrieved_cases (id varchar(36) not null, created_at datetime(6) not null, rank_order integer not null, similarity_score float(53), message_id varchar(36) not null, retrieved_evaluation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table diagnosis_assistant_suggestions (id varchar(36) not null, confidence float(53), created_at datetime(6) not null, display_name varchar(256) not null, locality_risk_level varchar(16), rank_order integer not null, rationale TEXT, was_primary_suggestion bit not null, disease_id varchar(36), evaluation_id varchar(36) not null, message_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table diagnosis_assistant_threads (id varchar(36) not null, created_at datetime(6) not null, status varchar(16) not null, updated_at datetime(6) not null, doctor_user_id varchar(36) not null, evaluation_id varchar(36) not null, hospital_id varchar(36), primary key (id)) engine=InnoDB;
create table diagnosis_feedback_events (id varchar(36) not null, created_at datetime(6) not null, feedback_notes TEXT, feedback_type varchar(48) not null, final_diagnosis_label varchar(256), accepted_assistant_message_id varchar(36), doctor_user_id varchar(36) not null, evaluation_id varchar(36) not null, final_disease_id varchar(36), hospital_id varchar(36), thread_id varchar(36), primary key (id)) engine=InnoDB;
create table disease_specialties (disease_id varchar(36) not null, specialty_id varchar(36) not null, primary key (disease_id, specialty_id)) engine=InnoDB;
create table disease_symptoms (disease_id varchar(36) not null, symptom_id varchar(36) not null, primary key (disease_id, symptom_id)) engine=InnoDB;
create table diseases (id varchar(36) not null, code varchar(32) not null, created_at datetime(6) not null, name varchar(128) not null, updated_at datetime(6) not null, specialty_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table evaluation_differential_diagnoses (id varchar(36) not null, confidence decimal(5,2), created_at datetime(6) not null, display_name varchar(255) not null, locality_risk_level varchar(16), rank_order integer not null, rationale TEXT, disease_id varchar(36), evaluation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table evaluation_recommended_tests (id varchar(36) not null, created_at datetime(6) not null, reason TEXT, sort_order integer not null, source varchar(16) not null, test_name varchar(255) not null, evaluation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table events (id varchar(36) not null, created_at datetime(6) not null, resolved_at datetime(6), started_at datetime(6) not null, status varchar(16) not null, updated_at datetime(6) not null, disease_id varchar(36) not null, patient_id varchar(36) not null, primary_doctor_user_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_department_resources (id varchar(36) not null, department_code varchar(32) not null, department_name varchar(128) not null, level_label varchar(64), notes varchar(512), occupied_beds integer not null, status varchar(32) not null, total_beds integer not null, updated_at datetime(6) not null, hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_inventory_items (id varchar(36) not null, capacity_quantity integer not null, category varchar(64), critical_threshold integer not null, current_quantity integer not null, item_code varchar(32) not null, item_name varchar(128) not null, location varchar(128), status varchar(32) not null, target_quantity integer not null, unit varchar(32), updated_at datetime(6) not null, hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_inventory_movements (id varchar(36) not null, created_at datetime(6) not null, movement_type varchar(32) not null, notes TEXT, quantity_delta integer not null, related_supply_request_id varchar(36), unit varchar(32), hospital_id varchar(36) not null, inventory_item_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_operational_contacts (id varchar(36) not null, is_assignable bit not null, availability_status varchar(32), contact_channel varchar(32), contact_value varchar(255), department_code varchar(32), display_name varchar(255) not null, is_notifiable bit not null, role_label varchar(128) not null, updated_at datetime(6) not null, hospital_id varchar(36) not null, user_id varchar(36), primary key (id)) engine=InnoDB;
create table hospital_operational_group_members (id varchar(36) not null, created_at datetime(6) not null, contact_id varchar(36) not null, group_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_operational_groups (id varchar(36) not null, is_assignable bit not null, department_code varchar(32), group_code varchar(32) not null, group_name varchar(128) not null, group_type varchar(32) not null, is_notifiable bit not null, updated_at datetime(6) not null, hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_resource_snapshots (id varchar(36) not null, available_beds integer not null, captured_at datetime(6) not null, created_at datetime(6) not null, doctors_on_shift integer not null, icu_available_beds integer not null, icu_total_beds integer not null, isolation_rooms_available integer not null, isolation_rooms_total integer not null, nurses_on_shift integer not null, oxygen_available_units integer not null, oxygen_capacity_units integer not null, source varchar(16) not null, specialists_on_shift integer not null, total_beds integer not null, hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospital_staffing_profiles (id varchar(36) not null, headcount integer not null, on_call_count integer not null, on_shift_count integer not null, role_code varchar(32) not null, role_name varchar(128) not null, standby_count integer not null, updated_at datetime(6) not null, hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table hospitals (id varchar(36) not null, active bit not null, address varchar(512), bed_count integer, code varchar(32) not null, created_at datetime(6) not null, doctor_count integer, invite_code varchar(64), latitude decimal(10,7), longitude decimal(10,7), name varchar(255) not null, nurse_count integer, phone varchar(32), postal_code varchar(16), updated_at datetime(6) not null, municipality_id varchar(36), primary key (id)) engine=InnoDB;
create table municipalities (id varchar(36) not null, code varchar(32) not null, created_at datetime(6) not null, latitude decimal(10,7), longitude decimal(10,7), name varchar(128) not null, updated_at datetime(6) not null, state_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table operational_notifications (id varchar(36) not null, audience_label varchar(255), delivery_channel varchar(32), delivery_status_detail varchar(255), message TEXT, sent_at datetime(6) not null, sent_by_user_id varchar(36), source_action_code varchar(32), status varchar(32) not null, audience_contact_id varchar(36), audience_group_id varchar(36), hospital_id varchar(36) not null, recommendation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table operational_recommendation_audit (id varchar(36) not null, actor_user_id varchar(36), created_at datetime(6) not null, event_label varchar(255), event_payload_json TEXT, event_type varchar(32) not null, recommendation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table operational_recommendations (id varchar(36) not null, affected_departments_json TEXT, affected_resources_json TEXT, allowed_status_transitions_json TEXT, available_actions_json TEXT, category varchar(64), confidence_score decimal(5,2), created_at datetime(6) not null, created_by_mode varchar(32) not null, description TEXT, display_category_label varchar(64), display_severity_label varchar(32), display_status_label varchar(32), expected_impact varchar(512), expires_at datetime(6), image_mode varchar(32), input_context_json TEXT, model_provider varchar(64), model_version varchar(64), presentation_variant varchar(32), primary_action_code varchar(32), rationale_json TEXT, recommended_actions_json TEXT, resolved_at datetime(6), severity varchar(16) not null, status varchar(32) not null, title varchar(255) not null, type varchar(32) not null, updated_at datetime(6) not null, urgency_window varchar(128), assigned_owner_user_id varchar(36), hospital_id varchar(36) not null, primary_department_resource_id varchar(36), primary_inventory_item_id varchar(36), primary_staffing_profile_id varchar(36), source_alert_id varchar(36), source_outbreak_id varchar(36), primary key (id)) engine=InnoDB;
create table operational_tasks (id varchar(36) not null, created_at datetime(6) not null, created_by_user_id varchar(36), deadline_at datetime(6), department_label varchar(255), notes TEXT, owner_label varchar(255), owner_user_id varchar(36), priority varchar(16) not null, source_action_code varchar(32), status varchar(32) not null, updated_at datetime(6) not null, hospital_id varchar(36) not null, owner_contact_id varchar(36), owner_group_id varchar(36), recommendation_id varchar(36) not null, recommended_by_recommendation_id varchar(36), primary key (id)) engine=InnoDB;
create table outbreaks (id varchar(36) not null, case_count integer not null, confirmation_status varchar(16) not null, created_at datetime(6) not null, ended_at datetime(6), scope varchar(16) not null, started_at datetime(6) not null, status varchar(16) not null, updated_at datetime(6) not null, disease_id varchar(36) not null, municipality_id varchar(36), state_id varchar(36), primary key (id)) engine=InnoDB;
create table patient_evaluation_files (id varchar(36) not null, content_base64 TEXT, document_type varchar(32), file_name varchar(255) not null, file_size_bytes bigint, mime_type varchar(128) not null, storage_key varchar(512) not null, uploaded_at datetime(6) not null, evaluation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table patient_evaluations (id varchar(36) not null, clinical_notes TEXT, created_at datetime(6) not null, doctor_feedback_notes TEXT, final_decision_source varchar(48), final_diagnosis_label varchar(256), finalized_at datetime(6), status varchar(16) not null, symptoms_text TEXT not null, updated_at datetime(6) not null, doctor_user_id varchar(36) not null, event_id varchar(36), final_disease_id varchar(36), patient_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table patients (id varchar(36) not null, birth_date date not null, created_at datetime(6) not null, full_name varchar(255) not null, height_cm decimal(5,2), postal_code varchar(16), sex varchar(16) not null, updated_at datetime(6) not null, weight_kg decimal(5,2), hospital_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table privileges (id varchar(36) not null, code varchar(128) not null, created_at datetime(6) not null, description varchar(255), updated_at datetime(6) not null, primary key (id)) engine=InnoDB;
create table role_privileges (role_id varchar(36) not null, privilege_id varchar(36) not null, primary key (role_id, privilege_id)) engine=InnoDB;
create table roles (id varchar(36) not null, code varchar(64) not null, created_at datetime(6) not null, description varchar(255), name varchar(128) not null, updated_at datetime(6) not null, primary key (id)) engine=InnoDB;
create table specialties (id varchar(36) not null, code varchar(32) not null, created_at datetime(6) not null, description varchar(255), name varchar(128) not null, updated_at datetime(6) not null, primary key (id)) engine=InnoDB;
create table states (id varchar(36) not null, code varchar(32) not null, created_at datetime(6) not null, description varchar(255), name varchar(128) not null, updated_at datetime(6) not null, primary key (id)) engine=InnoDB;
create table supply_requests (id varchar(36) not null, created_at datetime(6) not null, destination varchar(255), priority varchar(16), quantity integer not null, requested_by_user_id varchar(36), requested_needed_by datetime(6), source_action_code varchar(32), status varchar(32) not null, suggested_supplier varchar(255), supply_type_label varchar(255), unit varchar(32), updated_at datetime(6) not null, hospital_id varchar(36) not null, inventory_item_id varchar(36), linked_recommendation_inventory_item_id varchar(36), recommendation_id varchar(36) not null, primary key (id)) engine=InnoDB;
create table symptoms (id varchar(36) not null, code varchar(32) not null, created_at datetime(6) not null, name varchar(255) not null, updated_at datetime(6) not null, primary key (id)) engine=InnoDB;
create table user_roles (user_id varchar(36) not null, role_id varchar(36) not null, primary key (user_id, role_id)) engine=InnoDB;
create table users (id varchar(36) not null, active bit not null, created_at datetime(6) not null, email varchar(255) not null, external_auth_id varchar(128) not null, full_name varchar(255) not null, last_login_at datetime(6), license_number varchar(64), status enum ('ACTIVE','DISABLED','PENDING') not null, updated_at datetime(6) not null, hospital_id varchar(36), specialty_id varchar(36), primary key (id)) engine=InnoDB;
create index idx_dam_thread on diagnosis_assistant_messages (thread_id);
create index idx_dam_thread_seq on diagnosis_assistant_messages (thread_id, sequence_no);
create index idx_darc_message on diagnosis_assistant_retrieved_cases (message_id);
create index idx_darc_retrieved on diagnosis_assistant_retrieved_cases (retrieved_evaluation_id);
create index idx_das_message on diagnosis_assistant_suggestions (message_id);
create index idx_das_evaluation on diagnosis_assistant_suggestions (evaluation_id);
create index idx_das_disease on diagnosis_assistant_suggestions (disease_id);
create index idx_dat_evaluation on diagnosis_assistant_threads (evaluation_id);
create index idx_dat_doctor on diagnosis_assistant_threads (doctor_user_id);
create index idx_dat_hospital on diagnosis_assistant_threads (hospital_id);
alter table diagnosis_assistant_threads add constraint UKmd0qa5h09wpgvnm1egkej8c6s unique (evaluation_id);
create index idx_dfe_evaluation on diagnosis_feedback_events (evaluation_id);
create index idx_dfe_thread on diagnosis_feedback_events (thread_id);
create index idx_dfe_doctor on diagnosis_feedback_events (doctor_user_id);
create index idx_dfe_hospital on diagnosis_feedback_events (hospital_id);
create index idx_dfe_type on diagnosis_feedback_events (feedback_type);
create index idx_disease_symptoms_disease on disease_symptoms (disease_id);
create index idx_disease_symptoms_symptom on disease_symptoms (symptom_id);
alter table diseases add constraint UK1go03fs7gxneljj3m2whj7mqv unique (code);
create index idx_edd_evaluation on evaluation_differential_diagnoses (evaluation_id);
create index idx_edd_disease on evaluation_differential_diagnoses (disease_id);
create index idx_ert_evaluation on evaluation_recommended_tests (evaluation_id);
create index idx_events_patient_disease_status on events (patient_id, disease_id, status);
alter table hospitals add constraint UKsijspqk5a41oaf6gwhgneij9k unique (code);
alter table hospitals add constraint UK9lr2stph9iqb7189wr0pw2vrc unique (invite_code);
alter table municipalities add constraint UK4k5k487j9mtbf1ts33ccqy6ev unique (code);
create index idx_pef_evaluation on patient_evaluation_files (evaluation_id);
create index idx_pe_patient on patient_evaluations (patient_id);
create index idx_pe_doctor on patient_evaluations (doctor_user_id);
create index idx_pe_event on patient_evaluations (event_id);
create index idx_pe_status on patient_evaluations (status);
alter table privileges add constraint UKkifi80wf6aej5p2yx8sjfo8wu unique (code);
alter table roles add constraint UKch1113horj4qr56f91omojv8 unique (code);
alter table specialties add constraint UK8hq46e4ylgbhk67ke0u9y52i3 unique (code);
alter table states add constraint UK352ys3ohulkcpevklqvmkkut6 unique (code);
create index idx_symptoms_code on symptoms (code);
alter table symptoms add constraint UK2t33icsin6l8bk4spc2k5ooxp unique (code);
alter table symptoms add constraint UKc36q1csqqkwe0j8rv95e41o6r unique (name);
alter table users add constraint UK6dotkott2kjsp8vw4d0m25fb7 unique (email);
alter table users add constraint UKqjmmf24v4gu9hprrtyjgxwcir unique (external_auth_id);
alter table alerts add constraint FK7j5k6p82ud37x3jet9nf1pkty foreign key (outbreak_id) references outbreaks (id);
alter table diagnoses add constraint FK6wylprd8tbc36t4pmyf1nhtcj foreign key (doctor_user_id) references users (id);
alter table diagnoses add constraint FKadc5ojte947mfrhoj440ce0s3 foreign key (event_id) references events (id);
alter table diagnosis_assistant_messages add constraint FK5vinm3eaajld3ocixmeqcorsq foreign key (thread_id) references diagnosis_assistant_threads (id);
alter table diagnosis_assistant_retrieved_cases add constraint FKk2j6ac43xy4enb9wf7clw8cnl foreign key (message_id) references diagnosis_assistant_messages (id);
alter table diagnosis_assistant_retrieved_cases add constraint FK5nvph2r3f1hte7xdgstc09oxf foreign key (retrieved_evaluation_id) references patient_evaluations (id);
alter table diagnosis_assistant_suggestions add constraint FK6x5pvu76fonwthe5msfgoyjsx foreign key (disease_id) references diseases (id);
alter table diagnosis_assistant_suggestions add constraint FKcjm3ti8typc2iu9t7i7seq1n5 foreign key (evaluation_id) references patient_evaluations (id);
alter table diagnosis_assistant_suggestions add constraint FKfc8yu1rm8cfhcdoq8j4fnew2t foreign key (message_id) references diagnosis_assistant_messages (id);
alter table diagnosis_assistant_threads add constraint FKrdx04o4syymyvd6yhvpndd1uo foreign key (doctor_user_id) references users (id);
alter table diagnosis_assistant_threads add constraint FK55v6vvqwjovpsvgnfh3i53712 foreign key (evaluation_id) references patient_evaluations (id);
alter table diagnosis_assistant_threads add constraint FKauyhqdidnbxaaqjqc1s7yxvvn foreign key (hospital_id) references hospitals (id);
alter table diagnosis_feedback_events add constraint FK1j3b0c0rek1mbamdijb5y31le foreign key (accepted_assistant_message_id) references diagnosis_assistant_messages (id);
alter table diagnosis_feedback_events add constraint FKqu9fbcx0ubuyx2d7yi3ojxb7o foreign key (doctor_user_id) references users (id);
alter table diagnosis_feedback_events add constraint FKry2a4o3ibnw9p9uac0fnekdvy foreign key (evaluation_id) references patient_evaluations (id);
alter table diagnosis_feedback_events add constraint FKepbi0u9h06013l6nydwny9ftd foreign key (final_disease_id) references diseases (id);
alter table diagnosis_feedback_events add constraint FK7bm2g718muplagaldyvjy9eft foreign key (hospital_id) references hospitals (id);
alter table diagnosis_feedback_events add constraint FKfr7n8v33ukcdt9cyjjtgdxfpc foreign key (thread_id) references diagnosis_assistant_threads (id);
alter table disease_specialties add constraint FKjvqt7sl6inxw5bx3ols83893k foreign key (specialty_id) references specialties (id);
alter table disease_specialties add constraint FKslg3onwcevws5n8mv9y6sh556 foreign key (disease_id) references diseases (id);
alter table disease_symptoms add constraint FK98scsxldkfr0kkv4ic4ncog7e foreign key (symptom_id) references symptoms (id);
alter table disease_symptoms add constraint FKhrkj9wnghqf7dqmg6vfcbbloa foreign key (disease_id) references diseases (id);
alter table diseases add constraint FKfs95l78b2miav0xs9dggvtw0y foreign key (specialty_id) references specialties (id);
alter table evaluation_differential_diagnoses add constraint FKfhkvfjpc0284hf0v6xbrbtaid foreign key (disease_id) references diseases (id);
alter table evaluation_differential_diagnoses add constraint FKoykmwmunsv2ay0oom43iurgr0 foreign key (evaluation_id) references patient_evaluations (id);
alter table evaluation_recommended_tests add constraint FKmakb4g0q8xc91gqiu3p86uiij foreign key (evaluation_id) references patient_evaluations (id);
alter table events add constraint FKpy00t90k18hthynohyje20pd8 foreign key (disease_id) references diseases (id);
alter table events add constraint FKatseqnrbr7j6qoibdow55iyt3 foreign key (patient_id) references patients (id);
alter table events add constraint FKf2f25k8nipylt43v5afmq50g9 foreign key (primary_doctor_user_id) references users (id);
alter table hospital_department_resources add constraint FK4ryjvbejsncf49c95v2i86rer foreign key (hospital_id) references hospitals (id);
alter table hospital_inventory_items add constraint FK91ur2kkc7ksbso2rfl12wirpk foreign key (hospital_id) references hospitals (id);
alter table hospital_inventory_movements add constraint FK3berh0s2xtafatkifkbs2srhn foreign key (hospital_id) references hospitals (id);
alter table hospital_inventory_movements add constraint FKjk5ds010gq4jcgqkawhbw31l1 foreign key (inventory_item_id) references hospital_inventory_items (id);
alter table hospital_operational_contacts add constraint FKd7rdlh0vlfurpcx4em3vn9krf foreign key (hospital_id) references hospitals (id);
alter table hospital_operational_contacts add constraint FK76u5ctc3jn39jru944e0ftpfg foreign key (user_id) references users (id);
alter table hospital_operational_group_members add constraint FKep8ss3f3rflyblvmdxs72w5aw foreign key (contact_id) references hospital_operational_contacts (id);
alter table hospital_operational_group_members add constraint FKbehtfhw3taq5iuct2m0esvyl4 foreign key (group_id) references hospital_operational_groups (id);
alter table hospital_operational_groups add constraint FKgj8vg2evoyrot27qtvnbrxr24 foreign key (hospital_id) references hospitals (id);
alter table hospital_resource_snapshots add constraint FKrd2cank3jlc9tm2redu22xtry foreign key (hospital_id) references hospitals (id);
alter table hospital_staffing_profiles add constraint FKul076pnhw5kqywryis6udado foreign key (hospital_id) references hospitals (id);
alter table hospitals add constraint FK5i0cw4r8a0400lq8r00hxd410 foreign key (municipality_id) references municipalities (id);
alter table municipalities add constraint FK539bqc43gn4d8uk9dwrph81q0 foreign key (state_id) references states (id);
alter table operational_notifications add constraint FKea5lkdo7sv3skxj6d4hvm7c0g foreign key (audience_contact_id) references hospital_operational_contacts (id);
alter table operational_notifications add constraint FK5xmhqt90lllyai3gfui2ga6lr foreign key (audience_group_id) references hospital_operational_groups (id);
alter table operational_notifications add constraint FK39e7i6k1iww7ra13fl0fct81b foreign key (hospital_id) references hospitals (id);
alter table operational_notifications add constraint FK33slgp5vuxrmwvpqdhbglby4h foreign key (recommendation_id) references operational_recommendations (id);
alter table operational_recommendation_audit add constraint FKcvjulapg4owmvvo9gkdw7tpb8 foreign key (recommendation_id) references operational_recommendations (id);
alter table operational_recommendations add constraint FKr1x1kpv69ly0dk7hij0guc6lt foreign key (assigned_owner_user_id) references users (id);
alter table operational_recommendations add constraint FKidu30pcpelblck17yrular5i4 foreign key (hospital_id) references hospitals (id);
alter table operational_recommendations add constraint FK5jnmoqh2u910ncge2qam4qwb1 foreign key (primary_department_resource_id) references hospital_department_resources (id);
alter table operational_recommendations add constraint FK8mkp1h99mlle86yx6gjwevnco foreign key (primary_inventory_item_id) references hospital_inventory_items (id);
alter table operational_recommendations add constraint FKyqhj1n0k2q8prfbugj4t8bjb foreign key (primary_staffing_profile_id) references hospital_staffing_profiles (id);
alter table operational_recommendations add constraint FKdon9v50i9wer61g4s205vkpp0 foreign key (source_alert_id) references alerts (id);
alter table operational_recommendations add constraint FKhhn080j3o4p6ybvbpw7sk0s8k foreign key (source_outbreak_id) references outbreaks (id);
alter table operational_tasks add constraint FKx97dq4t6mjcwwxtjg9xivpd6 foreign key (hospital_id) references hospitals (id);
alter table operational_tasks add constraint FKmxhsq6ae9fpcl9arjef3tsp1v foreign key (owner_contact_id) references hospital_operational_contacts (id);
alter table operational_tasks add constraint FK7m4k84a7u1t4hhhp4o6lun75b foreign key (owner_group_id) references hospital_operational_groups (id);
alter table operational_tasks add constraint FKr7lmfi0hcccys8l7fnue8rdj2 foreign key (recommendation_id) references operational_recommendations (id);
alter table operational_tasks add constraint FKsm2gchgdmx58i1ago33amemcj foreign key (recommended_by_recommendation_id) references operational_recommendations (id);
alter table outbreaks add constraint FKmhs8btkfolbksy9bi7rgpxrry foreign key (disease_id) references diseases (id);
alter table outbreaks add constraint FKih8ye6wf02xaxj7jcwq2w7dsw foreign key (municipality_id) references municipalities (id);
alter table outbreaks add constraint FK1adxvlet8jmohgmrl6i7qwk27 foreign key (state_id) references states (id);
alter table patient_evaluation_files add constraint FKg23ncrm24exysilv6icfd49uu foreign key (evaluation_id) references patient_evaluations (id);
alter table patient_evaluations add constraint FKrlpus6itexlipj362ru5abn99 foreign key (doctor_user_id) references users (id);
alter table patient_evaluations add constraint FKg4mjdl8n0crjm8bi7x4blwbt7 foreign key (event_id) references events (id);
alter table patient_evaluations add constraint FKaa3n3d0sxgw1u5phlf725waxc foreign key (final_disease_id) references diseases (id);
alter table patient_evaluations add constraint FK7uc0c7jgb7ah7ww400fn79x6t foreign key (patient_id) references patients (id);
alter table patients add constraint FKavr69byb4acg3j289g1oq08pk foreign key (hospital_id) references hospitals (id);
alter table role_privileges add constraint FKbosd0iqvr1efg44c01jcuvdxt foreign key (privilege_id) references privileges (id);
alter table role_privileges add constraint FKddceebgln19s0c4tjwj01v1ou foreign key (role_id) references roles (id);
alter table supply_requests add constraint FKkap8jrbtfkxgxdo1v66nmpq9x foreign key (hospital_id) references hospitals (id);
alter table supply_requests add constraint FK99xnw7xgp4ccjmgkft0qcssly foreign key (inventory_item_id) references hospital_inventory_items (id);
alter table supply_requests add constraint FK5vwdtai2lvxenpy4xblyvox9k foreign key (linked_recommendation_inventory_item_id) references hospital_inventory_items (id);
alter table supply_requests add constraint FKeqcyv0pmhn537cgujx2h668bq foreign key (recommendation_id) references operational_recommendations (id);
alter table user_roles add constraint FKh8ciramu9cc9q3qcqiv4ue8a6 foreign key (role_id) references roles (id);
alter table user_roles add constraint FKhfh9dx7w3ubf1co1vdev94g3f foreign key (user_id) references users (id);
alter table users add constraint FKpp87ghj920xhrlf63rdeaufe1 foreign key (hospital_id) references hospitals (id);
alter table users add constraint FKih74rpug03pac4o5mqt12j9cl foreign key (specialty_id) references specialties (id);

-- Base catalog required before V1 and later data migrations.
-- States represent Mexican federal entities.
INSERT INTO states (id, code, name, description, created_at, updated_at) VALUES
('40000000-0000-0000-0000-000000000001', 'AGS',  'Aguascalientes',   'Estado de Aguascalientes', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000002', 'BC',   'Baja California',  'Estado de Baja California', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000003', 'BCS',  'Baja California Sur', 'Estado de Baja California Sur', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000004', 'CAM',  'Campeche',         'Estado de Campeche', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000005', 'COA',  'Coahuila de Zaragoza', 'Estado de Coahuila de Zaragoza', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000006', 'COL',  'Colima',           'Estado de Colima', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000007', 'CHP',  'Chiapas',          'Estado de Chiapas', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000008', 'CHH',  'Chihuahua',        'Estado de Chihuahua', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000009', 'CDMX', 'Ciudad de Mexico', 'Entidad federativa Ciudad de Mexico', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000010', 'DUR',  'Durango',          'Estado de Durango', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000011', 'GUA',  'Guanajuato',       'Estado de Guanajuato', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000012', 'GRO',  'Guerrero',         'Estado de Guerrero', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000013', 'HID',  'Hidalgo',          'Estado de Hidalgo', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000014', 'JAL',  'Jalisco',          'Estado de Jalisco', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000015', 'MEX',  'Mexico',           'Estado de Mexico', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000016', 'MIC',  'Michoacan de Ocampo', 'Estado de Michoacan de Ocampo', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000017', 'MOR',  'Morelos',          'Estado de Morelos', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000018', 'NAY',  'Nayarit',          'Estado de Nayarit', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000019', 'NL',   'Nuevo Leon',       'Estado de Nuevo Leon', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000020', 'OAX',  'Oaxaca',           'Estado de Oaxaca', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000021', 'PUE',  'Puebla',           'Estado de Puebla', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000022', 'QRO',  'Queretaro',        'Estado de Queretaro', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000023', 'ROO',  'Quintana Roo',     'Estado de Quintana Roo', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000024', 'SLP',  'San Luis Potosi',  'Estado de San Luis Potosi', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000025', 'SIN',  'Sinaloa',          'Estado de Sinaloa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000026', 'SON',  'Sonora',           'Estado de Sonora', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000027', 'TAB',  'Tabasco',          'Estado de Tabasco', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000028', 'TAM',  'Tamaulipas',       'Estado de Tamaulipas', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000029', 'TLA',  'Tlaxcala',         'Estado de Tlaxcala', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000030', 'VER',  'Veracruz de Ignacio de la Llave', 'Estado de Veracruz de Ignacio de la Llave', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000031', 'YUC',  'Yucatan',          'Estado de Yucatan', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('40000000-0000-0000-0000-000000000032', 'ZAC',  'Zacatecas',        'Estado de Zacatecas', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Specialties
INSERT INTO specialties (id, code, name, description, created_at, updated_at) VALUES
('50000000-0000-0000-0000-000000000001', 'GEN',  'General Medicine',  'Primary care and general practice',         CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000002', 'CARD', 'Cardiology',        'Heart and circulatory conditions',          CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000003', 'PULM', 'Pulmonology',       'Respiratory system',                        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000004', 'INF',  'Infectious Diseases','Infectious and communicable diseases',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000005', 'PED',  'Pediatrics',        'Care of infants, children, and adolescents',CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000006', 'GASTRO','Gastroenterology', 'Digestive system and gastrointestinal conditions', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000007', 'NEURO','Neurology',         'Brain, nervous system, and neurologic conditions', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000008', 'ENT',  'Otolaryngology',    'Ear, nose, throat, head and neck conditions', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000009', 'DERM', 'Dermatology',       'Skin, hair, and nail conditions',            CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000010', 'GYN',  'Gynecology',        'Female reproductive health conditions',      CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000011', 'URO',  'Urology',           'Urinary tract and male reproductive conditions', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000012', 'FAM',  'Family Medicine',   'Comprehensive primary care across ages',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000013', 'OPH',  'Ophthalmology',     'Eye and vision conditions',                  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('50000000-0000-0000-0000-000000000014', 'DENT', 'Dentistry',         'Oral and dental conditions',                 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Diseases and symptoms are seeded by Flyway data migrations from the disease catalog CSV.

-- Roles
INSERT INTO roles (id, code, name, description, created_at, updated_at) VALUES
('00000000-0000-0000-0000-000000000001', 'SYSTEM_ADMIN',   'System Administrator',   'Platform-wide administrative access',          CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000002', 'HOSPITAL_ADMIN', 'Hospital Administrator', 'Administrative access scoped to one hospital', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('00000000-0000-0000-0000-000000000003', 'DOCTOR',         'Doctor',                 'Clinical user scoped to one hospital',         CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Privileges
INSERT INTO privileges (id, code, description, created_at, updated_at) VALUES
('10000000-0000-0000-0000-000000000001', 'alerts.read',       'Read alerts',                CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000002', 'alerts.manage',     'Manage alerts',              CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000003', 'users.read',        'Read users',                 CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000004', 'users.manage',      'Create/update users',        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000005', 'roles.manage',      'Manage RBAC roles',          CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000006', 'diagnosis.create',  'Create diagnosis entries',   CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000007', 'hospitals.read',    'Read hospitals',             CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000008', 'hospitals.manage',  'Create/update hospitals',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000009', 'patients.read',     'Read patients',              CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000010', 'patients.manage',   'Create/update patients',     CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000011', 'diseases.read',     'Read diseases',              CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000012', 'diseases.manage',   'Manage diseases catalog',    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000013', 'specialties.read',  'Read specialties',           CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000014', 'specialties.manage','Manage specialties catalog', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000015', 'outbreaks.read',    'Read outbreaks',             CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000016', 'outbreaks.manage',  'Manage outbreaks',           CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000017', 'states.read',       'Read states',                CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000018', 'states.manage',     'Manage states',              CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000019', 'diagnosis.assist',  'Use the AI diagnosis assistant chat', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('10000000-0000-0000-0000-000000000020', 'admin.operations',  'Access hospital admin operational features', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- SYSTEM_ADMIN: everything
INSERT INTO role_privileges (role_id, privilege_id) VALUES
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000002'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000003'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000004'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000005'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000006'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000007'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000008'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000009'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000010'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000011'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000012'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000013'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000014'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000015'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000016'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000017'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000018'),
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000019');
-- admin.operations for SYSTEM_ADMIN
INSERT INTO role_privileges (role_id, privilege_id) VALUES
('00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000020');

-- HOSPITAL_ADMIN: hospital-scoped clinical + admin.
INSERT INTO role_privileges (role_id, privilege_id) VALUES
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000003'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000004'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000007'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000009'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000010'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000011'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000013'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000015'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000016'),
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000017');
-- admin.operations for HOSPITAL_ADMIN
INSERT INTO role_privileges (role_id, privilege_id) VALUES
('00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000020');

-- DOCTOR: read alerts + clinical features for their patients
INSERT INTO role_privileges (role_id, privilege_id) VALUES
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000001'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000006'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000009'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000010'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000011'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000013'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000015'),
('00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000019');

-- Users and user_roles are seeded by DevSeeder.java in dev profile (creates real Firebase
-- identities with password "Password123!" and writes matching DB rows with the real UID).
-- Do not insert users here or DevSeeder's idempotency guard will short-circuit.

-- ============================================================
-- HOSPITALS (needed as FK parent for operational seed data)
-- municipality_id is left NULL here; Flyway V2 sets real values in local-persistent profile.
-- ============================================================
INSERT INTO hospitals (id, code, name, address, phone, invite_code, active, postal_code, bed_count, doctor_count, nurse_count, municipality_id, latitude, longitude, created_at, updated_at) VALUES
('30000000-0000-0000-0000-000000000001', 'HGZ-21', 'Hospital General Zona 21',  'Av. Principal 100, Monterrey',    '+52 81 0000 0001', 'INVITE-HGZ21', TRUE, '64000', 240, 72, 180, NULL, 25.6866142, -100.3161126, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('30000000-0000-0000-0000-000000000002', 'HRE-05', 'Hospital Regional Este',     'Calle 5 Ote 200, Xochimilco',     '+52 55 0000 0002', 'INVITE-HRE05', TRUE, '16000', 320, 96, 240, NULL, 19.2572310,  -99.1037420,  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- ============================================================
-- OPERATIONAL MODULE SEED DATA (Hospital 1: HGZ-21, Monterrey)
-- ============================================================

-- hospital_resource_snapshots
INSERT INTO hospital_resource_snapshots (id, hospital_id, total_beds, available_beds, icu_total_beds, icu_available_beds, isolation_rooms_total, isolation_rooms_available, oxygen_capacity_units, oxygen_available_units, doctors_on_shift, nurses_on_shift, specialists_on_shift, source, captured_at, created_at) VALUES
('20000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 240, 60, 20, 5, 10, 3, 500, 150, 42, 130, 15, 'MANUAL', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- hospital_department_resources
INSERT INTO hospital_department_resources (id, hospital_id, department_code, department_name, level_label, total_beds, occupied_beds, status, notes, updated_at) VALUES
('21000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'EMERGENCY',   'Emergency Department',       'Level 1', 40,  35, 'HIGH_LOAD', 'Near capacity',         CURRENT_TIMESTAMP),
('21000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', 'GENERAL',     'General Ward',               'Level 2', 80,  65, 'NORMAL',    NULL,                    CURRENT_TIMESTAMP),
('21000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', 'ICU',         'Intensive Care Unit',        'Level 3', 20,  15, 'HIGH_LOAD', 'Surge expected',        CURRENT_TIMESTAMP),
('21000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001', 'RESPIRATORY', 'Respiratory Ward',           'Level 2', 30,  25, 'HIGH_LOAD', 'Outbreak isolation active', CURRENT_TIMESTAMP),
('21000000-0000-0000-0000-000000000005', '30000000-0000-0000-0000-000000000001', 'PEDIATRICS',  'Pediatric Ward',             'Level 2', 25,  15, 'NORMAL',    NULL,                    CURRENT_TIMESTAMP);

-- hospital_staffing_profiles
INSERT INTO hospital_staffing_profiles (id, hospital_id, role_code, role_name, headcount, on_shift_count, on_call_count, standby_count, updated_at) VALUES
('22000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'EMERGENCY_PHYSICIAN',  'Emergency Physicians',            10, 4, 3, 3, CURRENT_TIMESTAMP),
('22000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', 'ICU_NURSE',            'ICU Nurses',                      18, 6, 6, 6, CURRENT_TIMESTAMP),
('22000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', 'PULMONOLOGIST',        'Pulmonologists',                   5, 2, 2, 1, CURRENT_TIMESTAMP),
('22000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001', 'INFECTIOUS_DISEASE',   'Infectious Disease Specialists',   4, 2, 1, 1, CURRENT_TIMESTAMP),
('22000000-0000-0000-0000-000000000005', '30000000-0000-0000-0000-000000000001', 'GENERAL_PRACTITIONER', 'General Practitioners',           30, 12, 9, 9, CURRENT_TIMESTAMP),
('22000000-0000-0000-0000-000000000006', '30000000-0000-0000-0000-000000000001', 'NURSING_STAFF',        'Nursing Staff',                   80, 30, 25, 25, CURRENT_TIMESTAMP);

-- hospital_inventory_items
INSERT INTO hospital_inventory_items (id, hospital_id, item_code, item_name, category, location, current_quantity, capacity_quantity, unit, critical_threshold, target_quantity, status, updated_at) VALUES
('23000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'N95_MASK',     'N95 Respirator Masks',   'PPE',          'Central Supply', 500,  2000, 'units',    200,  1500, 'LOW',      CURRENT_TIMESTAMP),
('23000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', 'VENTILATOR',   'Mechanical Ventilators', 'EQUIPMENT',    'ICU',            8,    20,   'units',    3,    15,   'NORMAL',   CURRENT_TIMESTAMP),
('23000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', 'O2_CYLINDER',  'Oxygen Cylinders',       'SUPPLY',       'Gas Room',       80,   200,  'cylinders',40,   150,  'NORMAL',   CURRENT_TIMESTAMP),
('23000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000001', 'IV_FLUID',     'IV Saline Solution',     'PHARMACEUTICAL','Pharmacy',      300,  1000, 'bags',     100,  800,  'NORMAL',   CURRENT_TIMESTAMP),
('23000000-0000-0000-0000-000000000005', '30000000-0000-0000-0000-000000000001', 'ISO_GOWN',     'Isolation Gowns',        'PPE',          'Central Supply', 150,  1000, 'units',    200,  700,  'CRITICAL', CURRENT_TIMESTAMP),
('23000000-0000-0000-0000-000000000006', '30000000-0000-0000-0000-000000000001', 'ANTIVIRAL',    'Antiviral Medications',  'PHARMACEUTICAL','Pharmacy',      60,   300,  'doses',    50,   250,  'LOW',      CURRENT_TIMESTAMP);

-- operational_recommendations (3 example records for hospital 1)
INSERT INTO operational_recommendations (id, hospital_id, source_alert_id, source_outbreak_id, type, severity, status, category, title, description, expected_impact, urgency_window, confidence_score, rationale_json, recommended_actions_json, affected_departments_json, affected_resources_json, created_by_mode, created_at, updated_at) VALUES
('24000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', NULL, NULL, 'BED_CAPACITY', 'CRITICAL', 'NEW', 'BED_CAPACITY',
  'ICU Capacity Critical - Activate Surge Protocol',
  'ICU occupancy is at 75% with 5 beds remaining. Trending upward due to respiratory disease activity.',
  'Prevent ICU overflow and ensure critical care availability',
  'Immediately',
  0.95,
  '["ICU occupancy trending 75% with active outbreak","Respiratory case referrals increasing 18% week over week"]',
  '["Activate ICU surge protocol","Convert step-down unit beds to monitored ICU capacity","Expedite eligible ICU discharges"]',
  '["ICU","Step-Down Unit"]',
  '["ICU Beds","Ventilators","ICU Nursing"]',
  'RULE_ENGINE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('24000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', NULL, NULL, 'STAFFING', 'HIGH', 'ACCEPTED', 'STAFFING',
  'Increase Emergency Physician Staffing',
  'Doctor-to-bed ratio is below recommended threshold during high outbreak season.',
  'Improve patient throughput during outbreak surge',
  'Next staffing rotation',
  0.85,
  '["Doctor-to-bed ratio is 1:57, below recommended 1:30","Multiple active outbreaks in catchment area"]',
  '["Activate 3 additional on-call physicians","Redirect from low-urgency departments"]',
  '["Emergency Department","ICU"]',
  '["Physician Staff","On-Call Roster"]',
  'RULE_ENGINE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('24000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', NULL, NULL, 'ISOLATION', 'MEDIUM', 'NEW', 'ISOLATION',
  'Review PPE Stock Levels',
  'Current PPE inventory (N95 masks, isolation gowns) is below minimum threshold given active respiratory outbreak.',
  'Maintain staff protection and infection control capability',
  'Within 48 hours',
  0.78,
  '["N95 mask stock at 500 units vs 200 critical threshold","Isolation gowns critically low at 150 units"]',
  '["Emergency procurement of 1500 N95 masks","Order 700 isolation gowns","Audit and restock PPE distribution"]',
  '["Emergency Department","Respiratory Ward","General Admission"]',
  '["N95 Masks","Isolation Gowns"]',
  'RULE_ENGINE', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

UPDATE operational_recommendations
SET primary_department_resource_id = '21000000-0000-0000-0000-000000000003',
    primary_staffing_profile_id = '22000000-0000-0000-0000-000000000002',
    primary_inventory_item_id = '23000000-0000-0000-0000-000000000002',
    presentation_variant = 'alert',
    primary_action_code = 'ASSIGN_TASK',
    available_actions_json = '[{"code":"ASSIGN_TASK","label":"Assign task","style":"primary","enabled":true},{"code":"NOTIFY_STAFF","label":"Notify staff","style":"secondary","enabled":true},{"code":"ORDER_SUPPLIES","label":"Order supplies","style":"secondary","enabled":true}]',
    allowed_status_transitions_json = '["ACCEPTED","ASSIGNED","REJECTED"]',
    display_category_label = 'Bed Capacity',
    display_severity_label = 'Critical',
    display_status_label = 'New',
    expires_at = CURRENT_TIMESTAMP
WHERE id = '24000000-0000-0000-0000-000000000001';

UPDATE operational_recommendations
SET primary_department_resource_id = '21000000-0000-0000-0000-000000000001',
    primary_staffing_profile_id = '22000000-0000-0000-0000-000000000001',
    presentation_variant = 'urgent',
    primary_action_code = 'ASSIGN_TASK',
    available_actions_json = '[{"code":"ASSIGN_TASK","label":"Assign task","style":"primary","enabled":true},{"code":"NOTIFY_STAFF","label":"Notify staff","style":"secondary","enabled":true},{"code":"ORDER_SUPPLIES","label":"Order supplies","style":"secondary","enabled":false,"disabledReason":"No inventory item linked"}]',
    allowed_status_transitions_json = '["ASSIGNED","COMPLETED","REJECTED"]',
    display_category_label = 'Staffing',
    display_severity_label = 'High',
    display_status_label = 'Accepted',
    expires_at = CURRENT_TIMESTAMP
WHERE id = '24000000-0000-0000-0000-000000000002';

UPDATE operational_recommendations
SET primary_department_resource_id = '21000000-0000-0000-0000-000000000004',
    primary_staffing_profile_id = '22000000-0000-0000-0000-000000000004',
    primary_inventory_item_id = '23000000-0000-0000-0000-000000000005',
    presentation_variant = 'standard',
    primary_action_code = 'ORDER_SUPPLIES',
    available_actions_json = '[{"code":"ASSIGN_TASK","label":"Assign task","style":"secondary","enabled":true},{"code":"NOTIFY_STAFF","label":"Notify staff","style":"secondary","enabled":true},{"code":"ORDER_SUPPLIES","label":"Order supplies","style":"primary","enabled":true}]',
    allowed_status_transitions_json = '["ACCEPTED","ASSIGNED","REJECTED"]',
    display_category_label = 'Isolation',
    display_severity_label = 'Medium',
    display_status_label = 'New',
    expires_at = CURRENT_TIMESTAMP
WHERE id = '24000000-0000-0000-0000-000000000003';

-- hospital_operational_contacts
INSERT INTO hospital_operational_contacts (id, hospital_id, user_id, display_name, role_label, department_code, contact_channel, contact_value, availability_status, is_assignable, is_notifiable, updated_at) VALUES
('25000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', NULL, 'Dr. Elena Ramirez', 'ICU Supervisor', 'ICU', 'PHONE', '+52 81 1111 0001', 'ON_SHIFT', TRUE, TRUE, CURRENT_TIMESTAMP),
('25000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', NULL, 'Miguel Torres', 'Emergency Operations Lead', 'EMERGENCY', 'PHONE', '+52 81 1111 0002', 'ON_CALL', TRUE, TRUE, CURRENT_TIMESTAMP),
('25000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', NULL, 'Lucia Gomez', 'Central Supply Coordinator', 'SUPPLY', 'EMAIL', 'supply@hgz21.local', 'AVAILABLE', TRUE, TRUE, CURRENT_TIMESTAMP);

-- hospital_operational_groups
INSERT INTO hospital_operational_groups (id, hospital_id, group_code, group_name, group_type, department_code, is_assignable, is_notifiable, updated_at) VALUES
('26000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'ICU_RESPONSE', 'ICU Response Team', 'INCIDENT_RESPONSE', 'ICU', TRUE, TRUE, CURRENT_TIMESTAMP),
('26000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', 'ED_LEADS', 'Emergency Department Leads', 'DEPARTMENT', 'EMERGENCY', TRUE, TRUE, CURRENT_TIMESTAMP),
('26000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', 'SUPPLY_CHAIN', 'Supply Chain Team', 'SUPPLY_CHAIN', 'SUPPLY', TRUE, TRUE, CURRENT_TIMESTAMP);

-- hospital_operational_group_members
INSERT INTO hospital_operational_group_members (id, group_id, contact_id, created_at) VALUES
('27000000-0000-0000-0000-000000000001', '26000000-0000-0000-0000-000000000001', '25000000-0000-0000-0000-000000000001', CURRENT_TIMESTAMP),
('27000000-0000-0000-0000-000000000002', '26000000-0000-0000-0000-000000000002', '25000000-0000-0000-0000-000000000002', CURRENT_TIMESTAMP),
('27000000-0000-0000-0000-000000000003', '26000000-0000-0000-0000-000000000003', '25000000-0000-0000-0000-000000000003', CURRENT_TIMESTAMP);

-- hospital_inventory_movements
INSERT INTO hospital_inventory_movements (id, hospital_id, inventory_item_id, movement_type, quantity_delta, unit, notes, related_supply_request_id, created_at) VALUES
('28000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', '23000000-0000-0000-0000-000000000005', 'CONSUMPTION', -120, 'units', 'Respiratory isolation surge usage', NULL, CURRENT_TIMESTAMP),
('28000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000001', '23000000-0000-0000-0000-000000000001', 'REPLENISHMENT', 300, 'units', 'Recent PPE restock', NULL, CURRENT_TIMESTAMP),
('28000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000001', '23000000-0000-0000-0000-000000000003', 'MANUAL_ADJUSTMENT', -15, 'cylinders', 'Adjusted after overnight count', NULL, CURRENT_TIMESTAMP);


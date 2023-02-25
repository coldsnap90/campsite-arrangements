--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_data (
    id integer NOT NULL,
    park character varying(50),
    site character varying(50),
    site_type character varying(50),
    campground character varying(50),
    inner_campground character varying(50),
    arrival_day character varying(5),
    arrival_month character varying(20),
    arrival_date character varying(20),
    nights character varying(5),
    equiptment character varying(50),
    email character varying(50),
    password character varying(50),
    party_size character varying(50),
    contact_num character varying(11),
    logged boolean,
    booked boolean,
    occupant boolean,
    occupant_first_name character varying(50),
    occupant_last_name character varying(50),
    occupant_address character varying(50),
    occupant_postal_code character varying(50),
    occupant_phone_num character varying(50),
    user_id integer
);


--
-- Name: booking_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_data_id_seq OWNED BY public.booking_data.id;


--
-- Name: booking_time_test; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_time_test (
    id integer NOT NULL,
    site character varying(50),
    time_delta character varying(20),
    date_delta character varying(20),
    success boolean,
    failed_at character varying(20),
    failed_number integer
);


--
-- Name: booking_time_test_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_time_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_time_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_time_test_id_seq OWNED BY public.booking_time_test.id;


--
-- Name: parks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parks (
    id integer NOT NULL,
    park_site character varying(50)
);


--
-- Name: parks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parks_id_seq OWNED BY public.parks.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role (
    id integer NOT NULL,
    name character varying(50)
);


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: roles_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles_users (
    user_id integer,
    role_id integer
);


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sites (
    id integer NOT NULL,
    campground character varying(50),
    inner_campground character varying(50),
    names character varying(50),
    park_id integer
);


--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(100),
    password character varying(100),
    "firstName" character varying(20),
    "lastName" character varying(20),
    confirmed boolean,
    "billingAddress" character varying(50),
    "postalCode" character varying(50),
    city character varying(50),
    province character varying(50),
    country character varying(50),
    subscription character varying(50),
    "cId" character varying(50),
    "sId" character varying(50),
    scan integer,
    sub_day character varying(50),
    active boolean,
    phone_num character varying(11),
    is_admin boolean
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: booking_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_data ALTER COLUMN id SET DEFAULT nextval('public.booking_data_id_seq'::regclass);


--
-- Name: booking_time_test id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_time_test ALTER COLUMN id SET DEFAULT nextval('public.booking_time_test_id_seq'::regclass);


--
-- Name: parks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parks ALTER COLUMN id SET DEFAULT nextval('public.parks_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: booking_data; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_data (id, park, site, site_type, campground, inner_campground, arrival_day, arrival_month, arrival_date, nights, equiptment, email, password, party_size, contact_num, logged, booked, occupant, occupant_first_name, occupant_last_name, occupant_address, occupant_postal_code, occupant_phone_num, user_id) FROM stdin;
\.


--
-- Data for Name: booking_time_test; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_time_test (id, site, time_delta, date_delta, success, failed_at, failed_number) FROM stdin;
\.


--
-- Data for Name: parks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.parks (id, park_site) FROM stdin;
1	Alice Lake
2	Bamberton
3	Bear Creek
4	Beatton
5	Beaumont
6	Big Bar Lake
7	Birkenhead Lake
8	Blanket Creek
9	Bowron Lake
10	Bromley Rock
11	Carp Lake
12	Champion Lakes
13	Charlie Lake
14	Chilliwack Lake
15	Cowichan River
16	Crooked River
17	Cultus Lake
18	Dry Gulch
19	E.C. Manning
20	Elk Falls
21	Ellison
22	Englishman River Falls
23	Fillongley
24	Fintry
25	French Beach
26	Gladstone
27	Golden Ears
28	Goldstream
29	Gordon Bay
30	Green Lake
31	Herald
32	Horsefly Lake
33	Inland Lake
34	Juan de Fuca
35	Juniper Beach
36	Kekuli Bay
37	Kentucky Alleyne
38	Kettle River
39	Kikomun Creek
40	Kleanza Creek
41	Kokanee Creek
42	Kootenay Lake
43	Lac La Hache
44	Lac Le Jeune
45	Lakelse Lake
46	Liard River Hot Springs
47	Little Qualicum Falls
48	Loveland Bay
49	Mabel Lake
50	Martha Creek
51	McDonald Creek
52	Miracle Beach
53	Moberly Lake
54	Monck
55	Montague Harbour Marine
56	Morton Lake
57	Mount Fernie
58	Mount Robson
59	Moyie Lake
60	Nairn  Falls
61	Nairn Falls
62	Newcastle Island Marine
63	North Thompson River
64	Okanagan Lake North
65	Okanagan Lake South
66	Otter Lake
67	Paarens Beach
68	Paul Lake
69	Porpoise Bay
70	Porteau Cove
71	Premier Lake
72	Prudhomme Lake
73	Purden Lake
74	Rathtrevor Beach
75	Red Bluff
76	Rolley Lake
77	Rosebery
78	Ruckle
79	Saltery Bay
80	Sasquatch
81	Shuswap Lake
82	Silver Lake
83	Skagit Valley
84	Smelt Bay
85	Sowchea Bay
86	Sproat Lake
87	Stamp River
88	Stemwinder
89	Strathcona
90	Summit Lake
91	Swan Lake
92	sw̓iw̓s (Haynes Point)
93	sx̌ʷəx̌ʷnitkʷ (Okanagan Falls)
94	Syringa
95	Ten Mile Lake
96	Tweedsmuir South
97	Tyhee Lake
98	Tā Ch’ilā (Boya Lake)
99	Wasa Lake
100	Wells Gray
101	Whiskers Point
102	Meziadin Lake
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role (id, name) FROM stdin;
\.


--
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles_users (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sites (id, campground, inner_campground, names, park_id) FROM stdin;
1	A (Sites 1-55)	None	1	1
2	A (Sites 1-55)	None	2	1
3	A (Sites 1-55)	None	3	1
4	A (Sites 1-55)	None	4	1
5	A (Sites 1-55)	None	5	1
6	A (Sites 1-55)	None	6	1
7	A (Sites 1-55)	None	7	1
8	A (Sites 1-55)	None	8	1
9	A (Sites 1-55)	None	9	1
10	A (Sites 1-55)	None	10	1
11	A (Sites 1-55)	None	11	1
12	A (Sites 1-55)	None	12	1
13	A (Sites 1-55)	None	13	1
14	A (Sites 1-55)	None	14	1
15	A (Sites 1-55)	None	15	1
16	A (Sites 1-55)	None	16	1
17	A (Sites 1-55)	None	17	1
18	A (Sites 1-55)	None	18	1
19	A (Sites 1-55)	None	19	1
20	A (Sites 1-55)	None	20	1
21	A (Sites 1-55)	None	21	1
22	A (Sites 1-55)	None	22	1
23	A (Sites 1-55)	None	23	1
24	A (Sites 1-55)	None	24	1
25	A (Sites 1-55)	None	25	1
26	A (Sites 1-55)	None	26	1
27	A (Sites 1-55)	None	27	1
28	A (Sites 1-55)	None	28	1
29	A (Sites 1-55)	None	29	1
30	A (Sites 1-55)	None	30	1
31	A (Sites 1-55)	None	31	1
32	A (Sites 1-55)	None	32	1
33	A (Sites 1-55)	None	33	1
34	A (Sites 1-55)	None	34	1
35	A (Sites 1-55)	None	35	1
36	A (Sites 1-55)	None	36	1
37	A (Sites 1-55)	None	37	1
38	A (Sites 1-55)	None	38	1
39	A (Sites 1-55)	None	39	1
40	A (Sites 1-55)	None	40	1
41	A (Sites 1-55)	None	41	1
42	A (Sites 1-55)	None	43	1
43	A (Sites 1-55)	None	44	1
44	A (Sites 1-55)	None	45	1
45	A (Sites 1-55)	None	46	1
46	A (Sites 1-55)	None	47	1
47	A (Sites 1-55)	None	48	1
48	A (Sites 1-55)	None	49	1
49	A (Sites 1-55)	None	50	1
50	A (Sites 1-55)	None	51	1
51	A (Sites 1-55)	None	52	1
52	A (Sites 1-55)	None	53	1
53	A (Sites 1-55)	None	54	1
54	A (Sites 1-55)	None	55	1
55	B (Sites 56-96)	None	56	1
56	B (Sites 56-96)	None	57	1
57	B (Sites 56-96)	None	58	1
58	B (Sites 56-96)	None	59	1
59	B (Sites 56-96)	None	60	1
60	B (Sites 56-96)	None	61	1
61	B (Sites 56-96)	None	62	1
62	B (Sites 56-96)	None	63	1
63	B (Sites 56-96)	None	64	1
64	B (Sites 56-96)	None	65	1
65	B (Sites 56-96)	None	66	1
66	B (Sites 56-96)	None	67	1
67	B (Sites 56-96)	None	68	1
68	B (Sites 56-96)	None	69	1
69	B (Sites 56-96)	None	70	1
70	B (Sites 56-96)	None	71	1
71	B (Sites 56-96)	None	72	1
72	B (Sites 56-96)	None	73	1
73	B (Sites 56-96)	None	74	1
74	B (Sites 56-96)	None	75	1
75	B (Sites 56-96)	None	76	1
76	B (Sites 56-96)	None	77	1
77	B (Sites 56-96)	None	78	1
78	B (Sites 56-96)	None	79	1
79	B (Sites 56-96)	None	80	1
80	B (Sites 56-96)	None	81	1
81	B (Sites 56-96)	None	82	1
82	B (Sites 56-96)	None	83	1
83	B (Sites 56-96)	None	84	1
84	B (Sites 56-96)	None	85	1
85	B (Sites 56-96)	None	86	1
86	B (Sites 56-96)	None	87	1
87	B (Sites 56-96)	None	88	1
88	B (Sites 56-96)	None	89	1
89	B (Sites 56-96)	None	90	1
90	B (Sites 56-96)	None	91	1
91	B (Sites 56-96)	None	92	1
92	B (Sites 56-96)	None	93	1
93	B (Sites 56-96)	None	94	1
94	B (Sites 56-96)	None	95	1
95	B (Sites 56-96)	None	96	1
96	Walk-In	None	W97	1
97	Walk-In	None	W98	1
98	Walk-In	None	W99	1
99	Walk-In	None	W100	1
100	Walk-In	None	W101	1
101	Walk-In	None	W102	1
102	Walk-In	None	W103	1
103	Walk-In	None	W104	1
104	Walk-In	None	W105	1
105	Walk-In	None	W106	1
106	Group Sites	None	G1-Group A	1
107	Group Sites	None	G2-Group B	1
108	Sites 1-48	None	2A	2
109	Sites 1-48	None	2B	2
110	Sites 1-48	None	3	2
111	Sites 1-48	None	4	2
112	Sites 1-48	None	5	2
113	Sites 1-48	None	6	2
114	Sites 1-48	None	7	2
115	Sites 1-48	None	8	2
116	Sites 1-48	None	9	2
117	Sites 1-48	None	10	2
118	Sites 1-48	None	11	2
119	Sites 1-48	None	12	2
120	Sites 1-48	None	13	2
121	Sites 1-48	None	14	2
122	Sites 1-48	None	15	2
123	Sites 1-48	None	16	2
124	Sites 1-48	None	17	2
125	Sites 1-48	None	18	2
126	Sites 1-48	None	19	2
127	Sites 1-48	None	20	2
128	Sites 1-48	None	21	2
129	Sites 1-48	None	22	2
130	Sites 1-48	None	23	2
131	Sites 1-48	None	24	2
132	Sites 1-48	None	25A	2
133	Sites 1-48	None	25B	2
134	Sites 1-48	None	26	2
135	Sites 1-48	None	27	2
136	Sites 1-48	None	28	2
137	Sites 1-48	None	29	2
138	Sites 1-48	None	30	2
139	Sites 1-48	None	31A	2
140	Sites 1-48	None	31B	2
141	Sites 1-48	None	32	2
142	Sites 1-48	None	33	2
143	Sites 1-48	None	34	2
144	Sites 1-48	None	35	2
145	Sites 1-48	None	36	2
146	Sites 1-48	None	37	2
147	Sites 1-48	None	38	2
148	Sites 1-48	None	39A	2
149	Sites 1-48	None	39B	2
150	Sites 1-48	None	39	2
151	Sites 1-48	None	40	2
152	Sites 1-48	None	41	2
153	Sites 1-48	None	42	2
154	Sites 1-48	None	43	2
155	Sites 1-48	None	44	2
156	Sites 1-48	None	45	2
157	Sites 1-48	None	46	2
158	Sites 1-122	None	1	3
159	Sites 1-122	None	2	3
160	Sites 1-122	None	3	3
161	Sites 1-122	None	4	3
162	Sites 1-122	None	5	3
163	Sites 1-122	None	6	3
164	Sites 1-122	None	7	3
165	Sites 1-122	None	8	3
166	Sites 1-122	None	9	3
167	Sites 1-122	None	10	3
168	Sites 1-122	None	11	3
169	Sites 1-122	None	12	3
170	Sites 1-122	None	13	3
171	Sites 1-122	None	14	3
172	Sites 1-122	None	15	3
173	Sites 1-122	None	16	3
174	Sites 1-122	None	17	3
175	Sites 1-122	None	18	3
176	Sites 1-122	None	19	3
177	Sites 1-122	None	20	3
178	Sites 1-122	None	21	3
179	Sites 1-122	None	22	3
180	Sites 1-122	None	23	3
181	Sites 1-122	None	24	3
182	Sites 1-122	None	25	3
183	Sites 1-122	None	26	3
184	Sites 1-122	None	27	3
185	Sites 1-122	None	28	3
186	Sites 1-122	None	29	3
187	Sites 1-122	None	30	3
188	Sites 1-122	None	31	3
189	Sites 1-122	None	32	3
190	Sites 1-122	None	33	3
191	Sites 1-122	None	34	3
192	Sites 1-122	None	35	3
193	Sites 1-122	None	36	3
194	Sites 1-122	None	37	3
195	Sites 1-122	None	38	3
196	Sites 1-122	None	39	3
197	Sites 1-122	None	40	3
198	Sites 1-122	None	41	3
199	Sites 1-122	None	42	3
200	Sites 1-122	None	43	3
201	Sites 1-122	None	44	3
202	Sites 1-122	None	45	3
203	Sites 1-122	None	46	3
204	Sites 1-122	None	47	3
205	Sites 1-122	None	48	3
206	Sites 1-122	None	49	3
207	Sites 1-122	None	50	3
208	Sites 1-122	None	51	3
209	Sites 1-122	None	52	3
210	Sites 1-122	None	53	3
211	Sites 1-122	None	54	3
212	Sites 1-122	None	55	3
213	Sites 1-122	None	56	3
214	Sites 1-122	None	57	3
215	Sites 1-122	None	58	3
216	Sites 1-122	None	59	3
217	Sites 1-122	None	60	3
218	Sites 1-122	None	61	3
219	Sites 1-122	None	62	3
220	Sites 1-122	None	63	3
221	Sites 1-122	None	64	3
222	Sites 1-122	None	65	3
223	Sites 1-122	None	66	3
224	Sites 1-122	None	67	3
225	Sites 1-122	None	68	3
226	Sites 1-122	None	69	3
227	Sites 1-122	None	70	3
228	Sites 1-122	None	71	3
229	Sites 1-122	None	72	3
230	Sites 1-122	None	73	3
231	Sites 1-122	None	74	3
232	Sites 1-122	None	75	3
233	Sites 1-122	None	76	3
234	Sites 1-122	None	77	3
235	Sites 1-122	None	78	3
236	Sites 1-122	None	79	3
237	Sites 1-122	None	80	3
238	Sites 1-122	None	81	3
239	Sites 1-122	None	82	3
240	Sites 1-122	None	83	3
241	Sites 1-122	None	84	3
242	Sites 1-122	None	85	3
243	Sites 1-122	None	86	3
244	Sites 1-122	None	87	3
245	Sites 1-122	None	88	3
246	Sites 1-122	None	89	3
247	Sites 1-122	None	90	3
248	Sites 1-122	None	91	3
249	Sites 1-122	None	92	3
250	Sites 1-122	None	93	3
251	Sites 1-122	None	94	3
252	Sites 1-122	None	95	3
253	Sites 1-122	None	96	3
254	Sites 1-122	None	97	3
255	Sites 1-122	None	98	3
256	Sites 1-122	None	99	3
257	Sites 1-122	None	100	3
258	Sites 1-122	None	101	3
259	Sites 1-122	None	102	3
260	Sites 1-122	None	103	3
261	Sites 1-122	None	104	3
262	Sites 1-122	None	105	3
263	Sites 1-122	None	106	3
264	Sites 1-122	None	107	3
265	Sites 1-122	None	108	3
266	Sites 1-122	None	109	3
267	Sites 1-122	None	110	3
268	Sites 1-122	None	111	3
269	Sites 1-122	None	112	3
270	Sites 1-122	None	113	3
271	Sites 1-122	None	114	3
272	Sites 1-122	None	115	3
273	Sites 1-122	None	116	3
274	Sites 1-122	None	117	3
275	Sites 1-122	None	118	3
276	Sites 1-122	None	119	3
277	Sites 1-122	None	120	3
278	Sites 1-122	None	121	3
279	Sites 1-122	None	122	3
280	Sites 123-143	None	123	3
281	Sites 123-143	None	124	3
282	Sites 123-143	None	125	3
283	Sites 123-143	None	126	3
284	Sites 123-143	None	127	3
285	Sites 123-143	None	128	3
286	Sites 123-143	None	129	3
287	Sites 123-143	None	130	3
288	Sites 123-143	None	131	3
289	Sites 123-143	None	132	3
290	Sites 123-143	None	133	3
291	Sites 123-143	None	134	3
292	Sites 123-143	None	135	3
293	Sites 123-143	None	136	3
294	Sites 123-143	None	137	3
295	Sites 123-143	None	138	3
296	Sites 123-143	None	139	3
297	Sites 123-143	None	140	3
298	Sites 123-143	None	141	3
299	Sites 123-143	None	142	3
300	Sites 123-143	None	143	3
301	None	None	1	4
302	None	None	2	4
303	None	None	3	4
304	None	None	4	4
305	None	None	5	4
306	None	None	6	4
307	None	None	7	4
308	None	None	8	4
309	None	None	9	4
310	None	None	10	4
311	None	None	11	4
312	None	None	12	4
313	None	None	13	4
314	None	None	14	4
315	None	None	15	4
316	None	None	16	4
317	None	None	17	4
318	None	None	18	4
319	None	None	19	4
320	None	None	20	4
321	None	None	21	4
322	None	None	22	4
323	None	None	23	4
324	None	None	24	4
325	None	None	25	4
326	None	None	26	4
327	None	None	27	4
328	None	None	28	4
329	None	None	29	4
330	None	None	30	4
331	None	None	31	4
332	None	None	32	4
333	None	None	33	4
334	None	None	34	4
335	None	None	35	4
336	None	None	36	4
337	None	None	37	4
338	None	None	38	4
339	None	None	39	4
340	None	None	1	5
341	None	None	2	5
342	None	None	3	5
343	None	None	4	5
344	None	None	5	5
345	None	None	6	5
346	None	None	7	5
347	None	None	8	5
348	None	None	9	5
349	None	None	10	5
350	None	None	11	5
351	None	None	12	5
352	None	None	13	5
353	None	None	14	5
354	None	None	15	5
355	None	None	16	5
356	None	None	17	5
357	None	None	18	5
358	None	None	19	5
359	None	None	20	5
360	None	None	21	5
361	None	None	22	5
362	None	None	23	5
363	None	None	24	5
364	None	None	25	5
365	None	None	26	5
366	None	None	27	5
367	None	None	28	5
368	None	None	29	5
369	None	None	30	5
370	None	None	31	5
371	None	None	32	5
372	None	None	33	5
373	None	None	34	5
374	None	None	35	5
375	None	None	36	5
376	None	None	37	5
377	None	None	38	5
378	None	None	39	5
379	None	None	40	5
380	None	None	41	5
381	None	None	42	5
382	None	None	43	5
383	None	None	44	5
384	None	None	45	5
385	None	None	46	5
386	None	None	47	5
387	None	None	48	5
388	None	None	49	5
389	None	None	T1	5
390	None	None	T2	5
391	None	None	T3	5
392	None	None	T4	5
393	None	None	T5	5
394	Lakeshore Campground	None	1	6
395	Lakeshore Campground	None	2	6
396	Lakeshore Campground	None	3	6
397	Lakeshore Campground	None	4	6
398	Lakeshore Campground	None	5	6
399	Lakeshore Campground	None	6	6
400	Lakeshore Campground	None	7	6
401	Lakeshore Campground	None	8	6
402	Lakeshore Campground	None	9	6
403	Lakeshore Campground	None	10	6
404	Lakeshore Campground	None	11	6
405	Lakeshore Campground	None	12	6
406	Lakeshore Campground	None	13	6
407	Lakeshore Campground	None	14	6
408	Lakeshore Campground	None	15	6
409	Lakeshore Campground	None	16	6
410	Lakeshore Campground	None	17	6
411	Lakeshore Campground	None	18	6
412	Lakeshore Campground	None	19	6
413	Lakeshore Campground	None	20	6
414	Lakeshore Campground	None	21	6
415	Lakeshore Campground	None	22	6
416	Lakeshore Campground	None	23	6
417	Lakeshore Campground	None	24	6
418	Lakeshore Campground	None	25	6
419	Lakeshore Campground	None	26	6
420	Lakeshore Campground	None	27	6
421	Upper Campground	None	28	6
422	Upper Campground	None	29	6
423	Upper Campground	None	30	6
424	Upper Campground	None	31	6
425	Upper Campground	None	32	6
426	Upper Campground	None	33	6
427	Upper Campground	None	34	6
428	Upper Campground	None	35	6
429	Upper Campground	None	36	6
430	Upper Campground	None	37	6
431	Upper Campground	None	38	6
432	Upper Campground	None	39	6
433	Upper Campground	None	40	6
434	Upper Campground	None	41	6
435	Upper Campground	None	42	6
436	Upper Campground	None	43	6
437	Upper Campground	None	44	6
438	Upper Campground	None	45	6
439	Upper Campground	None	46	6
440	None	None	1	7
441	None	None	2	7
442	None	None	3	7
443	None	None	4	7
444	None	None	5	7
445	None	None	6	7
446	None	None	7	7
447	None	None	8	7
448	None	None	9	7
449	None	None	10	7
450	None	None	11	7
451	None	None	12	7
452	None	None	13	7
453	None	None	14	7
454	None	None	15	7
455	None	None	16	7
456	None	None	17	7
457	None	None	18	7
458	None	None	19	7
459	None	None	20	7
460	None	None	21	7
461	None	None	22	7
462	None	None	23	7
463	None	None	24	7
464	None	None	25	7
465	None	None	26	7
466	None	None	27	7
467	None	None	28	7
468	None	None	29	7
469	None	None	30	7
470	None	None	31	7
471	None	None	32	7
472	None	None	33	7
473	None	None	34	7
474	None	None	35	7
475	None	None	36	7
476	None	None	37	7
477	None	None	38	7
478	None	None	39	7
479	None	None	40	7
480	None	None	41	7
481	None	None	42	7
482	None	None	43	7
483	None	None	44	7
484	None	None	45	7
485	None	None	46	7
486	None	None	47	7
487	None	None	48	7
488	None	None	49	7
489	None	None	50	7
490	None	None	51	7
491	None	None	52	7
492	None	None	53	7
493	None	None	54	7
494	None	None	55	7
495	None	None	56	7
496	None	None	57	7
497	None	None	58	7
498	None	None	59	7
499	None	None	60	7
500	None	None	61	7
501	None	None	62	7
502	None	None	63	7
503	None	None	64	7
504	None	None	65	7
505	None	None	66	7
506	None	None	67	7
507	None	None	68	7
508	None	None	69	7
509	None	None	70	7
510	None	None	71	7
511	None	None	72	7
512	None	None	73	7
513	None	None	74	7
514	None	None	75	7
515	None	None	76	7
516	None	None	77	7
517	None	None	78	7
518	None	None	HD86	7
519	None	None	HD87	7
520	None	None	HD88	7
521	None	None	HD89	7
522	None	None	HD90	7
523	None	None	HD91	7
524	None	None	HD92	7
525	None	None	HD93	7
526	None	None	HD94	7
527	None	None	HD95	7
528	None	None	HD96	7
529	None	None	HD97	7
530	None	None	HD98	7
531	Campground	None	1	8
532	Campground	None	2	8
533	Campground	None	3	8
534	Campground	None	4	8
535	Campground	None	5	8
536	Campground	None	6	8
537	Campground	None	7	8
538	Campground	None	8	8
539	Campground	None	9	8
540	Campground	None	10	8
541	Campground	None	11	8
542	Campground	None	12	8
543	Campground	None	13	8
544	Campground	None	14	8
545	Campground	None	15	8
546	Campground	None	16	8
547	Campground	None	17	8
548	Campground	None	18	8
549	Campground	None	19	8
550	Campground	None	20	8
551	Campground	None	21	8
552	Campground	None	22	8
553	Campground	None	23	8
554	Campground	None	24	8
555	Campground	None	25	8
556	Campground	None	26	8
557	Campground	None	27	8
558	Campground	None	28	8
559	Campground	None	29	8
560	Campground	None	30	8
561	Campground	None	31	8
562	Campground	None	32	8
563	Campground	None	33	8
564	Campground	None	34	8
565	Campground	None	35	8
566	Campground	None	36	8
567	Campground	None	37	8
568	Campground	None	38	8
569	Campground	None	39	8
570	Campground	None	40	8
571	Campground	None	41	8
572	Campground	None	42	8
573	Campground	None	43	8
574	Campground	None	44	8
575	Campground	None	45	8
576	Campground	None	46	8
577	Campground	None	47	8
578	Campground	None	48	8
579	Campground	None	49	8
580	Campground	None	50	8
581	Campground	None	51	8
582	Campground	None	52	8
583	Campground	None	53	8
584	Campground	None	54	8
585	Campground	None	55	8
586	Campground	None	56	8
587	Campground	None	57	8
588	Campground	None	58	8
589	Campground	None	59	8
590	Campground	None	60	8
591	Campground	None	61	8
592	Campground	None	62	8
593	Campground	None	63	8
594	Campground	None	64	8
595	Campground	None	65	8
596	Campground	None	66	8
597	Campground	None	67	8
598	Campground	None	68	8
599	Campground	None	69	8
600	Campground	None	70	8
601	Campground	None	71	8
602	Campground	None	72	8
603	Campground	None	73	8
604	Campground	None	74	8
605	Campground	None	75	8
606	Campground	None	76	8
607	Campground	None	77	8
608	Campground	None	78	8
609	Campground	None	79	8
610	Campground	None	80	8
611	Campground	None	81	8
612	Campground	None	82	8
613	Campground	None	83	8
614	Campground	None	84	8
615	Campground	None	85	8
616	Campground	None	86	8
617	Campground	None	87	8
618	Campground	None	88	8
619	Campground	None	89	8
620	Campground	None	90	8
621	Campground	None	91	8
622	Campground	None	92	8
623	Campground	None	93	8
624	Campground	None	94	8
625	Campground	None	95	8
626	Campground	None	96	8
627	Campground	None	97	8
628	Campground	None	98	8
629	Campground	None	99	8
630	Campground	None	100	8
631	Campground	None	101	8
632	Campground	None	102	8
633	Campground	None	103	8
634	Campground	None	104	8
635	Campground	None	105	8
636	Group Sites	None	G1	8
637	Group Sites	None	G2	8
638	Bowron Lake Campground	None	1	9
639	Bowron Lake Campground	None	2	9
640	Bowron Lake Campground	None	3	9
641	Bowron Lake Campground	None	4	9
642	Bowron Lake Campground	None	5	9
643	Bowron Lake Campground	None	6	9
644	Bowron Lake Campground	None	7	9
645	Bowron Lake Campground	None	8	9
646	Bowron Lake Campground	None	9	9
647	Bowron Lake Campground	None	10	9
648	Bowron Lake Campground	None	11	9
649	Bowron Lake Campground	None	12	9
650	Bowron Lake Campground	None	13	9
651	Bowron Lake Campground	None	14	9
652	Bowron Lake Campground	None	15	9
653	Bowron Lake Campground	None	16	9
654	Bowron Lake Campground	None	17	9
655	Bowron Lake Campground	None	18	9
656	Bowron Lake Campground	None	19	9
657	Bowron Lake Campground	None	20	9
658	Bowron Lake Campground	None	21	9
659	Bowron Lake Campground	None	22	9
660	Bowron Lake Campground	None	23	9
661	Bowron Lake Campground	None	24	9
662	Bowron Lake Campground	None	25	9
663	None	None	1	10
664	None	None	2	10
665	None	None	3	10
666	None	None	4	10
667	None	None	5	10
668	None	None	6	10
669	None	None	7	10
670	None	None	8	10
671	None	None	9	10
672	None	None	10	10
673	None	None	11	10
674	None	None	12	10
675	None	None	13	10
676	None	None	14	10
677	None	None	15	10
678	None	None	16	10
679	None	None	17	10
680	None	None	B1	11
681	None	None	B2	11
682	None	None	B3	11
683	None	None	B4	11
684	None	None	B5	11
685	None	None	B6	11
686	None	None	S1	11
687	None	None	S2	11
688	None	None	SS1	11
689	None	None	SS2	11
690	None	None	SS3	11
691	None	None	SS4	11
692	None	None	SN1	11
693	None	None	SN2	11
694	None	None	SN3	11
695	None	None	SN4	11
696	None	None	Bert's Cabin	11
697	Campground	None	1	12
698	Campground	None	2	12
699	Campground	None	3	12
700	Campground	None	4	12
701	Campground	None	5	12
702	Campground	None	6	12
703	Campground	None	7	12
704	Campground	None	8	12
705	Campground	None	9	12
706	Campground	None	10	12
707	Campground	None	11	12
708	Campground	None	12	12
709	Campground	None	13	12
710	Campground	None	14	12
711	Campground	None	15	12
712	Campground	None	16	12
713	Campground	None	17	12
714	Campground	None	18	12
715	Campground	None	19	12
716	Campground	None	20	12
717	Campground	None	21	12
718	Campground	None	22	12
719	Campground	None	23	12
720	Campground	None	24	12
721	Campground	None	25	12
722	Campground	None	26	12
723	Campground	None	27	12
724	Campground	None	28	12
725	Campground	None	29	12
726	Campground	None	30	12
727	Campground	None	31	12
728	Campground	None	32	12
729	Campground	None	33	12
730	Campground	None	34	12
731	Campground	None	35	12
732	Campground	None	36	12
733	Campground	None	37	12
734	Campground	None	38	12
735	Campground	None	39	12
736	Campground	None	40	12
737	Campground	None	41	12
738	Campground	None	42	12
739	Campground	None	43	12
740	Campground	None	44	12
741	Campground	None	45	12
742	Campground	None	46	12
743	Campground	None	47	12
744	Campground	None	48	12
745	Campground	None	49	12
746	Campground	None	50	12
747	Campground	None	51	12
748	Campground	None	52	12
749	Campground	None	53	12
750	Campground	None	54	12
751	Campground	None	55	12
752	Campground	None	56	12
753	Campground	None	57	12
754	Campground	None	58	12
755	Campground	None	59	12
756	Campground	None	60	12
757	Campground	None	61	12
758	Campground	None	62	12
759	Campground	None	63	12
760	Campground	None	64	12
761	Campground	None	65	12
762	Campground	None	66	12
763	Campground	None	67	12
764	Campground	None	68	12
765	Campground	None	69	12
766	Campground	None	70	12
767	Campground	None	71	12
768	Campground	None	72	12
769	Campground	None	73	12
770	Campground	None	74	12
771	Campground	None	75	12
772	Campground	None	76	12
773	Campground	None	77	12
774	Campground	None	78	12
775	Campground	None	79	12
776	Campground	None	80	12
777	Campground	None	81	12
778	Campground	None	82	12
779	Campground	None	83	12
780	Campground	None	84	12
781	Campground	None	85	12
782	Campground	None	86	12
783	Campground	None	87	12
784	Campground	None	88	12
785	Campground	None	89	12
786	Campground	None	90	12
787	Campground	None	91	12
788	Campground	None	92	12
789	Campground	None	93	12
790	Campground	None	94	12
791	Campground	None	95	12
792	None	None	1	13
793	None	None	2	13
794	None	None	3	13
795	None	None	4	13
796	None	None	5	13
797	None	None	6	13
798	None	None	7	13
799	None	None	8	13
800	None	None	9	13
801	None	None	10	13
802	None	None	11	13
803	None	None	12	13
804	None	None	13	13
805	None	None	14	13
806	None	None	15	13
807	None	None	16	13
808	None	None	17	13
809	None	None	18	13
810	None	None	19	13
811	None	None	20	13
812	None	None	21	13
813	None	None	22	13
814	None	None	23	13
815	None	None	24	13
816	None	None	25	13
817	None	None	26	13
818	None	None	27	13
819	None	None	28	13
820	None	None	29	13
821	None	None	30	13
822	None	None	31	13
823	None	None	32	13
824	None	None	33	13
825	None	None	34	13
826	None	None	35	13
827	None	None	36	13
828	None	None	37	13
829	None	None	38	13
830	None	None	39	13
831	None	None	40	13
832	None	None	41	13
833	None	None	42	13
834	None	None	43	13
835	None	None	44	13
836	None	None	45	13
837	None	None	46	13
838	None	None	47	13
839	None	None	48	13
840	None	None	49	13
841	None	None	50	13
842	None	None	51	13
843	None	None	52	13
844	None	None	53	13
845	None	None	54	13
846	None	None	55	13
847	None	None	56	13
848	None	None	57	13
849	Greendrop Loop	None	G1	14
850	Greendrop Loop	None	G2	14
851	Greendrop Loop	None	G3	14
852	Greendrop Loop	None	G4	14
853	Greendrop Loop	None	G5	14
854	Greendrop Loop	None	G6	14
855	Greendrop Loop	None	G7	14
856	Greendrop Loop	None	G8	14
857	Greendrop Loop	None	G9	14
858	Greendrop Loop	None	G10	14
859	Greendrop Loop	None	G11	14
860	Greendrop Loop	None	G12	14
861	Greendrop Loop	None	G13	14
862	Greendrop Loop	None	G14	14
863	Greendrop Loop	None	G15	14
864	Greendrop Loop	None	G16	14
865	Greendrop Loop	None	G17	14
866	Greendrop Loop	None	G18	14
867	None	None	L2	14
868	None	None	L3	14
869	None	None	L4	14
870	None	None	L5	14
871	None	None	L6	14
872	None	None	L7	14
873	None	None	L8	14
874	None	None	L9	14
875	None	None	L10	14
876	None	None	L11	14
877	None	None	L12	14
878	None	None	L13	14
879	None	None	L14	14
880	None	None	L15	14
881	None	None	L16	14
882	None	None	L17	14
883	None	None	L18	14
884	None	None	L19	14
885	None	None	L20	14
886	None	None	L21	14
887	None	None	L22	14
888	None	None	L23	14
889	Paleface Loop	None	P1	14
890	Paleface Loop	None	P2	14
891	Paleface Loop	None	P3	14
892	Paleface Loop	None	P4	14
893	Paleface Loop	None	P5	14
894	Paleface Loop	None	P6	14
895	Paleface Loop	None	P7	14
896	Paleface Loop	None	P8	14
897	Paleface Loop	None	P9	14
898	Paleface Loop	None	P10	14
899	Paleface Loop	None	P11	14
900	Paleface Loop	None	P12	14
901	Paleface Loop	None	P13	14
902	Paleface Loop	None	P14	14
903	Paleface Loop	None	P15	14
904	Paleface Loop	None	P16	14
905	Paleface Loop	None	P17	14
906	Paleface Loop	None	P18	14
907	Paleface Loop	None	P19	14
908	Paleface Loop	None	P20	14
909	Paleface Loop	None	P21	14
910	Paleface Loop	None	P22	14
911	Paleface Loop	None	P23	14
912	Paleface Loop	None	P24	14
913	Paleface Loop	None	P25	14
914	Paleface Loop	None	P26	14
915	Paleface Loop	None	P27	14
916	Paleface Loop	None	P28	14
917	Paleface Loop	None	P29	14
918	Paleface Loop	None	P30	14
919	Paleface Loop	None	P31	14
920	Paleface Loop	None	P32	14
921	Paleface Loop	None	P33	14
922	Paleface Loop	None	P34	14
923	Paleface Loop	None	P35	14
924	Paleface Loop	None	P36	14
925	Paleface Loop	None	P37	14
926	Paleface Loop	None	P38	14
927	Paleface Loop	None	P39	14
928	Paleface Loop	None	P40	14
929	Paleface Loop	None	P41	14
930	Paleface Loop	None	P42	14
931	Paleface Loop	None	P43	14
932	Paleface Loop	None	P44	14
933	Paleface Loop	None	P45	14
934	Paleface Loop	None	P46	14
935	Paleface Loop	None	P47	14
936	Radium Loop	None	R1	14
937	Radium Loop	None	R2	14
938	Radium Loop	None	R3	14
939	Radium Loop	None	R4	14
940	Radium Loop	None	R5	14
941	Radium Loop	None	R6	14
942	Radium Loop	None	R7	14
943	Radium Loop	None	R8	14
944	Radium Loop	None	R9	14
945	Radium Loop	None	R10	14
946	Radium Loop	None	R11	14
947	Radium Loop	None	R12	14
948	Radium Loop	None	R13	14
949	Radium Loop	None	R14	14
950	Radium Loop	None	R15	14
951	Radium Loop	None	R16	14
952	Radium Loop	None	R17	14
953	Radium Loop	None	R18	14
954	Radium Loop	None	R19	14
955	Radium Loop	None	R20	14
956	Radium Loop	None	R21	14
957	Radium Loop	None	R22	14
958	Radium Loop	None	R23	14
959	Radium Loop	None	R24	14
960	Radium Loop	None	R25	14
961	Radium Loop	None	R26	14
962	Radium Loop	None	R27	14
963	Radium Loop	None	R28	14
964	Radium Loop	None	R29	14
965	Radium Loop	None	R30	14
966	Radium Loop	None	R31	14
967	Radium Loop	None	R32	14
968	Radium Loop	None	R33	14
969	Radium Loop	None	R34	14
970	Radium Loop	None	R35	14
971	Radium Loop	None	R36	14
972	Radium Loop	None	R37	14
973	Radium Loop	None	R38	14
974	Radium Loop	None	R39	14
975	Radium Loop	None	R40	14
976	Radium Loop	None	R41	14
977	Radium Loop	None	R42	14
978	Radium Loop	None	R43	14
979	Radium Loop	None	R44	14
980	Radium Loop	None	R45	14
981	Radium Loop	None	R46	14
982	Radium Loop	None	R47	14
983	Radium Loop	None	R48	14
984	Radium Loop	None	R49	14
985	Radium Loop	None	R50	14
986	Radium Loop	None	R51	14
987	Radium Loop	None	R52	14
988	Radium Loop	None	R53	14
989	Radium Loop	None	R54	14
990	Radium Loop	None	R55	14
991	Radium Loop	None	R56	14
992	Radium Loop	None	R57	14
993	Radium Loop	None	R58	14
994	Radium Loop	None	R59	14
995	Flora Loop	None	F1	14
996	Flora Loop	None	F2	14
997	Flora Loop	None	F3	14
998	Flora Loop	None	F4	14
999	Flora Loop	None	F5	14
1000	Flora Loop	None	F6	14
1001	Flora Loop	None	F7	14
1002	Flora Loop	None	F8	14
1003	Flora Loop	None	F9	14
1004	Flora Loop	None	F10	14
1005	Flora Loop	None	F11	14
1006	Flora Loop	None	F12	14
1007	Flora Loop	None	F13	14
1008	Flora Loop	None	F14	14
1009	Flora Loop	None	F15	14
1010	Flora Loop	None	F16	14
1011	Flora Loop	None	F17	14
1012	Flora Loop	None	F18	14
1013	Flora Loop	None	F19	14
1014	Flora Loop	None	F20	14
1015	Flora Loop	None	F21	14
1016	Flora Loop	None	F22	14
1017	Flora Loop	None	F23	14
1018	Flora Loop	None	F24	14
1019	Flora Loop	None	F25	14
1020	Flora Loop	None	F26	14
1021	Flora Loop	None	F27	14
1022	Flora Loop	None	F28	14
1023	Flora Loop	None	F29	14
1024	Flora Loop	None	F30	14
1025	Flora Loop	None	F31	14
1026	Flora Loop	None	F32	14
1027	None	None	3	15
1028	None	None	9	15
1029	None	None	12	15
1030	None	None	13	15
1031	None	None	14	15
1032	None	None	15	15
1033	None	None	17	15
1034	None	None	19	15
1035	None	None	20	15
1036	None	None	24	15
1037	None	None	25	15
1038	None	None	26	15
1039	None	None	27	15
1040	None	None	29	15
1041	None	None	31	15
1042	None	None	32	15
1043	None	None	33	15
1044	None	None	35	15
1045	None	None	36	15
1046	None	None	39	15
1047	None	None	40	15
1048	None	None	41	15
1049	None	None	42	15
1050	None	None	G1-Stoltz Pool	15
1051	None	None	G1-Horseshoe Bend	15
1052	None	None	1	16
1053	None	None	2	16
1054	None	None	3	16
1055	None	None	4	16
1056	None	None	5	16
1057	None	None	6	16
1058	None	None	7	16
1059	None	None	8	16
1060	None	None	9	16
1061	None	None	10	16
1062	None	None	11	16
1063	None	None	12	16
1064	None	None	13	16
1065	None	None	14	16
1066	None	None	15	16
1067	None	None	16	16
1068	None	None	17	16
1069	None	None	18	16
1070	None	None	19	16
1071	None	None	20	16
1072	None	None	21	16
1073	None	None	22	16
1074	None	None	23	16
1075	None	None	24	16
1076	None	None	25	16
1077	None	None	26	16
1078	None	None	27	16
1079	None	None	28	16
1080	None	None	29	16
1081	None	None	30	16
1082	None	None	31	16
1083	None	None	32	16
1084	None	None	33	16
1085	None	None	34	16
1086	None	None	35	16
1087	None	None	36	16
1088	None	None	37	16
1089	None	None	38	16
1090	None	None	39	16
1091	None	None	40	16
1092	None	None	41	16
1093	None	None	42	16
1094	None	None	43	16
1095	None	None	44	16
1096	None	None	45	16
1097	None	None	46	16
1098	None	None	47	16
1099	None	None	48	16
1100	None	None	49	16
1101	None	None	50	16
1102	None	None	51	16
1103	None	None	52	16
1104	None	None	53	16
1105	None	None	54	16
1106	None	None	55	16
1107	None	None	56	16
1108	None	None	57	16
1109	None	None	58	16
1110	None	None	59	16
1111	None	None	60	16
1112	None	None	61	16
1113	None	None	62	16
1114	None	None	63	16
1115	None	None	64	16
1116	None	None	65	16
1117	Enterance Bay	None	E1	17
1118	Enterance Bay	None	E2	17
1119	Enterance Bay	None	E3	17
1120	Enterance Bay	None	E4	17
1121	Enterance Bay	None	E5	17
1122	Enterance Bay	None	E6	17
1123	Enterance Bay	None	E7	17
1124	Enterance Bay	None	E8a	17
1125	Enterance Bay	None	E8b	17
1126	Enterance Bay	None	E9	17
1127	Enterance Bay	None	E10	17
1128	Enterance Bay	None	E11	17
1129	Enterance Bay	None	E12	17
1130	Enterance Bay	None	E13	17
1131	Enterance Bay	None	E14	17
1132	Enterance Bay	None	E15	17
1133	Enterance Bay	None	E16	17
1134	Enterance Bay	None	E17	17
1135	Enterance Bay	None	E18	17
1136	Enterance Bay	None	E19	17
1137	Enterance Bay	None	E20	17
1138	Enterance Bay	None	E21	17
1139	Enterance Bay	None	E22	17
1140	Enterance Bay	None	E23	17
1141	Enterance Bay	None	E24	17
1142	Enterance Bay	None	E25	17
1143	Enterance Bay	None	E26a	17
1144	Enterance Bay	None	E26b	17
1145	Enterance Bay	None	E27	17
1146	Enterance Bay	None	E28a	17
1147	Enterance Bay	None	E28b	17
1148	Enterance Bay	None	E29	17
1149	Enterance Bay	None	E30	17
1150	Enterance Bay	None	E31	17
1151	Enterance Bay	None	E32	17
1152	Enterance Bay	None	E33	17
1153	Enterance Bay	None	E34	17
1154	Enterance Bay	None	E35	17
1155	Enterance Bay	None	E36	17
1156	Enterance Bay	None	E37	17
1157	Enterance Bay	None	E38	17
1158	Enterance Bay	None	E38a	17
1159	Enterance Bay	None	E38b	17
1160	Enterance Bay	None	E39	17
1161	Enterance Bay	None	E40	17
1162	Enterance Bay	None	E41	17
1163	Enterance Bay	None	E42	17
1164	Enterance Bay	None	E43	17
1165	Enterance Bay	None	E44	17
1166	Enterance Bay	None	E45a	17
1167	Enterance Bay	None	E45b	17
1168	Enterance Bay	None	E46	17
1169	Enterance Bay	None	E47	17
1170	Clear Creek	None	C1	17
1171	Clear Creek	None	C2	17
1172	Clear Creek	None	C3	17
1173	Clear Creek	None	C4	17
1174	Clear Creek	None	C5	17
1175	Clear Creek	None	C6	17
1176	Clear Creek	None	C7	17
1177	Clear Creek	None	C8	17
1178	Clear Creek	None	C9	17
1179	Clear Creek	None	C10	17
1180	Clear Creek	None	C11	17
1181	Clear Creek	None	C12	17
1182	Clear Creek	None	C13	17
1183	Clear Creek	None	C14	17
1184	Clear Creek	None	C15	17
1185	Clear Creek	None	C16	17
1186	Clear Creek	None	C17	17
1187	Clear Creek	None	C18	17
1188	Clear Creek	None	C19	17
1189	Clear Creek	None	C20	17
1190	Clear Creek	None	C21	17
1191	Clear Creek	None	C22	17
1192	Clear Creek	None	C23	17
1193	Clear Creek	None	C24	17
1194	Clear Creek	None	C25	17
1195	Clear Creek	None	C26	17
1196	Clear Creek	None	C27	17
1197	Clear Creek	None	C28	17
1198	Clear Creek	None	C29	17
1199	Clear Creek	None	C30	17
1200	Clear Creek	None	C31	17
1201	Clear Creek	None	C32	17
1202	Clear Creek	None	C33	17
1203	Clear Creek	None	C34	17
1204	Clear Creek	None	C35	17
1205	Clear Creek	None	C36	17
1206	Clear Creek	None	C37	17
1207	Clear Creek	None	C38	17
1208	Clear Creek	None	C39	17
1209	Clear Creek	None	C40a	17
1210	Clear Creek	None	C40b	17
1211	Clear Creek	None	C41	17
1212	Clear Creek	None	C42	17
1213	Clear Creek	None	C43	17
1214	Clear Creek	None	C44	17
1215	Clear Creek	None	C45	17
1216	Clear Creek	None	C46	17
1217	Clear Creek	None	C47	17
1218	Clear Creek	None	C48	17
1219	Clear Creek	None	C49	17
1220	Clear Creek	None	C50	17
1221	Clear Creek	None	C51	17
1222	Clear Creek	None	C52	17
1223	Clear Creek	None	C53	17
1224	Clear Creek	None	C54	17
1225	Clear Creek	None	C55	17
1226	Clear Creek	None	C56	17
1227	Clear Creek	None	C57	17
1228	Clear Creek	None	C58	17
1229	Clear Creek	None	C59	17
1230	Clear Creek	None	C60	17
1231	Clear Creek	None	C61	17
1232	Clear Creek	None	C62	17
1233	Clear Creek	None	C63	17
1234	Clear Creek	None	C64	17
1235	Clear Creek	None	C65	17
1236	Clear Creek	None	C66	17
1237	Clear Creek	None	C67	17
1238	Clear Creek	None	C68	17
1239	Clear Creek	None	C69	17
1240	Clear Creek	None	C70	17
1241	Clear Creek	None	C71	17
1242	Clear Creek	None	C72	17
1243	Clear Creek	None	C73	17
1244	Clear Creek	None	C74	17
1245	Clear Creek	None	C75	17
1246	Clear Creek	None	C76	17
1247	Clear Creek	None	C77	17
1248	Clear Creek	None	C78	17
1249	Clear Creek	None	C79	17
1250	Clear Creek	None	C80	17
1251	Clear Creek	None	C81	17
1252	Clear Creek	None	C82	17
1253	Clear Creek	None	C83	17
1254	Clear Creek	None	C84	17
1255	Delta Grove	None	D1	17
1256	Delta Grove	None	D2	17
1257	Delta Grove	None	D3	17
1258	Delta Grove	None	D4	17
1259	Delta Grove	None	D5	17
1260	Delta Grove	None	D6	17
1261	Delta Grove	None	D7	17
1262	Delta Grove	None	D8	17
1263	Delta Grove	None	D9a	17
1264	Delta Grove	None	D9b	17
1265	Delta Grove	None	D10	17
1266	Delta Grove	None	D11a	17
1267	Delta Grove	None	D11b	17
1268	Delta Grove	None	D12	17
1269	Delta Grove	None	D13	17
1270	Delta Grove	None	D14	17
1271	Delta Grove	None	D15	17
1272	Delta Grove	None	D16	17
1273	Delta Grove	None	D17	17
1274	Delta Grove	None	D18	17
1275	Delta Grove	None	D19	17
1276	Delta Grove	None	D20	17
1277	Delta Grove	None	D21	17
1278	Delta Grove	None	D22	17
1279	Delta Grove	None	D23a	17
1280	Delta Grove	None	D23b	17
1281	Delta Grove	None	D24	17
1282	Delta Grove	None	D25	17
1283	Delta Grove	None	D26	17
1284	Delta Grove	None	D27a	17
1285	Delta Grove	None	D27b	17
1286	Delta Grove	None	D28	17
1287	Delta Grove	None	D29	17
1288	Delta Grove	None	D30a	17
1289	Delta Grove	None	D30b	17
1290	Delta Grove	None	D31	17
1291	Delta Grove	None	D32	17
1292	Delta Grove	None	D33	17
1293	Delta Grove	None	D34	17
1294	Delta Grove	None	D35	17
1295	Delta Grove	None	D36	17
1296	Delta Grove	None	D37	17
1297	Delta Grove	None	D38	17
1298	Delta Grove	None	D39a	17
1299	Delta Grove	None	D39b	17
1300	Delta Grove	None	D40	17
1301	Delta Grove	None	D41	17
1302	Delta Grove	None	D42	17
1303	Delta Grove	None	D43	17
1304	Delta Grove	None	D44	17
1305	Delta Grove	None	D45	17
1306	Delta Grove	None	D46	17
1307	Delta Grove	None	D47	17
1308	Delta Grove	None	D48	17
1309	Delta Grove	None	D49	17
1310	Delta Grove	None	D50	17
1311	Delta Grove	None	D51	17
1312	Delta Grove	None	D52	17
1313	Maple Bay	None	M1	17
1314	Maple Bay	None	M2	17
1315	Maple Bay	None	M3	17
1316	Maple Bay	None	M4	17
1317	Maple Bay	None	M5	17
1318	Maple Bay	None	M6	17
1319	Maple Bay	None	M7	17
1320	Maple Bay	None	M8	17
1321	Maple Bay	None	M9	17
1322	Maple Bay	None	M10	17
1323	Maple Bay	None	M11	17
1324	Maple Bay	None	M12	17
1325	Maple Bay	None	M13	17
1326	Maple Bay	None	M14	17
1327	Maple Bay	None	M15	17
1328	Maple Bay	None	M16	17
1329	Maple Bay	None	M17	17
1330	Maple Bay	None	M18	17
1331	Maple Bay	None	M19	17
1332	Maple Bay	None	M20	17
1333	Maple Bay	None	M21a	17
1334	Maple Bay	None	M21b	17
1335	Maple Bay	None	M22	17
1336	Maple Bay	None	M23	17
1337	Maple Bay	None	M24a	17
1338	Maple Bay	None	M24b	17
1339	Maple Bay	None	M25	17
1340	Maple Bay	None	M26	17
1341	Maple Bay	None	M27	17
1342	Maple Bay	None	M28	17
1343	Maple Bay	None	M29a	17
1344	Maple Bay	None	M29b	17
1345	Maple Bay	None	M30	17
1346	Maple Bay	None	M31	17
1347	Maple Bay	None	M32	17
1348	Maple Bay	None	M33	17
1349	Maple Bay	None	M34a	17
1350	Maple Bay	None	M34b	17
1351	Maple Bay	None	M35a	17
1352	Maple Bay	None	M35b	17
1353	Maple Bay	None	M36a	17
1354	Maple Bay	None	M36b	17
1355	Maple Bay	None	M37	17
1356	Maple Bay	None	M38a	17
1357	Maple Bay	None	M38b	17
1358	Maple Bay	None	M39	17
1359	Maple Bay	None	M40	17
1360	Maple Bay	None	M41	17
1361	Maple Bay	None	M42	17
1362	Maple Bay	None	M43a	17
1363	Maple Bay	None	M43b	17
1364	Maple Bay	None	M44	17
1365	Maple Bay	None	M45	17
1366	Maple Bay	None	M46	17
1367	Maple Bay	None	M47	17
1368	Maple Bay	None	M48	17
1369	Maple Bay	None	M49	17
1370	Maple Bay	None	M50	17
1371	Maple Bay	None	M51	17
1372	Maple Bay	None	M52a	17
1373	Maple Bay	None	M52b	17
1374	Maple Bay	None	M53	17
1375	Maple Bay	None	M54	17
1376	Maple Bay	None	M55	17
1377	Maple Bay	None	M56	17
1378	Maple Bay	None	M57	17
1379	Maple Bay	None	M58	17
1380	Maple Bay	None	M59	17
1381	Maple Bay	None	M60	17
1382	Maple Bay	None	M61	17
1383	Maple Bay	None	M62	17
1384	Maple Bay	None	M63	17
1385	Maple Bay	None	M64	17
1386	Maple Bay	None	M65	17
1387	Maple Bay	None	M66	17
1388	Maple Bay	None	M67	17
1389	Maple Bay	None	M68	17
1390	Maple Bay	None	M69	17
1391	Maple Bay	None	M70	17
1392	Maple Bay	None	M71	17
1393	Maple Bay	None	M72	17
1394	Maple Bay	None	M73	17
1395	Maple Bay	None	M74	17
1396	Maple Bay	None	M75	17
1397	Maple Bay	None	M76	17
1398	Maple Bay	None	M77	17
1399	Maple Bay	None	M78	17
1400	Maple Bay	None	M79	17
1401	Maple Bay	None	M80	17
1402	Maple Bay	None	M81	17
1403	Maple Bay	None	M82	17
1404	Maple Bay	None	M83	17
1405	Maple Bay	None	M84	17
1406	Maple Bay	None	M85	17
1407	Maple Bay	None	M86	17
1408	Maple Bay	None	M87	17
1409	Maple Bay	None	M88	17
1410	Maple Bay	None	M89	17
1411	Maple Bay	None	M90	17
1412	Maple Bay	None	M91	17
1413	Maple Bay	None	M92	17
1414	Maple Bay	None	M93	17
1415	Maple Bay	None	M94	17
1416	Maple Bay	None	M95	17
1417	Maple Bay	None	M96	17
1418	Maple Bay	None	M97	17
1419	Clear Creek	None	CBN1	17
1420	Clear Creek	None	CBN2	17
1421	Clear Creek	None	CBN3	17
1422	Clear Creek	None	CBN4	17
1423	Clear Creek	None	CBN5	17
1424	Clear Creek	None	CBN6	17
1425	Clear Creek	None	CBN7	17
1426	Clear Creek	None	CBN8	17
1427	Clear Creek	None	CBN9	17
1428	Clear Creek	None	CBN10	17
1429	Clear Creek	None	CBN11	17
1430	Clear Creek	None	CBN12	17
1431	Clear Creek	None	CBN13	17
1432	Clear Creek	None	CBN14	17
1433	Clear Creek	None	CBN15	17
1434	Clear Creek	None	CBN16	17
1435	Clear Creek	None	CBN17	17
1436	Clear Creek	None	CBN18	17
1437	Clear Creek	None	CBN19	17
1438	Clear Creek	None	CBN20	17
1439	Clear Creek	None	CBN21	17
1440	Clear Creek	None	CBN22	17
1441	Clear Creek	None	CBN23	17
1442	Clear Creek	None	CBN24	17
1443	Clear Creek	None	CBN25	17
1444	Group Sites	None	GA-Honeymoon Bay-Side A	17
1445	Group Sites	None	GB-Honeymoon Bay-Side B	17
1446	Group Sites	None	Westside Site-A	17
1447	Group Sites	None	Westside Site-B	17
1448	Campground	None	1	18
1449	Campground	None	2	18
1450	Campground	None	3	18
1451	Campground	None	4	18
1452	Campground	None	5	18
1453	Campground	None	6	18
1454	Campground	None	7	18
1455	Campground	None	8	18
1456	Campground	None	9	18
1457	Campground	None	10	18
1458	Campground	None	11	18
1459	Campground	None	12	18
1460	Campground	None	13	18
1461	Campground	None	14	18
1462	Campground	None	15	18
1463	Campground	None	16	18
1464	Campground	None	17	18
1465	Campground	None	18	18
1466	Campground	None	19	18
1467	Campground	None	20	18
1468	Campground	None	21	18
1469	Campground	None	22	18
1470	Campground	None	23	18
1471	Campground	None	24	18
1472	Campground	None	25	18
1473	Campground	None	26	18
1474	Campground	None	27	18
1475	Lightning Lake	 Lightning Lake - Large Loop 	1	19
1476	Lightning Lake	 Lightning Lake - Large Loop 	2	19
1477	Lightning Lake	 Lightning Lake - Large Loop 	3	19
1478	Lightning Lake	 Lightning Lake - Large Loop 	4	19
1479	Lightning Lake	 Lightning Lake - Large Loop 	5	19
1480	Lightning Lake	 Lightning Lake - Large Loop 	6	19
1481	Lightning Lake	 Lightning Lake - Large Loop 	7	19
1482	Lightning Lake	 Lightning Lake - Large Loop 	8	19
1483	Lightning Lake	 Lightning Lake - Large Loop 	9	19
1484	Lightning Lake	 Lightning Lake - Large Loop 	10	19
1485	Lightning Lake	 Lightning Lake - Large Loop 	11	19
1486	Lightning Lake	 Lightning Lake - Large Loop 	12	19
1487	Lightning Lake	 Lightning Lake - Large Loop 	13	19
1488	Lightning Lake	 Lightning Lake - Large Loop 	14	19
1489	Lightning Lake	 Lightning Lake - Large Loop 	15	19
1490	Lightning Lake	 Lightning Lake - Large Loop 	16	19
1491	Lightning Lake	 Lightning Lake - Large Loop 	17	19
1492	Lightning Lake	 Lightning Lake - Large Loop 	18	19
1493	Lightning Lake	 Lightning Lake - Large Loop 	19	19
1494	Lightning Lake	 Lightning Lake - Large Loop 	20	19
1495	Lightning Lake	 Lightning Lake - Large Loop 	21	19
1496	Lightning Lake	 Lightning Lake - Large Loop 	22	19
1497	Lightning Lake	 Lightning Lake - Large Loop 	23	19
1498	Lightning Lake	 Lightning Lake - Large Loop 	24	19
1499	Lightning Lake	 Lightning Lake - Large Loop 	25	19
1500	Lightning Lake	 Lightning Lake - Large Loop 	26	19
1501	Lightning Lake	 Lightning Lake - Large Loop 	27	19
1502	Lightning Lake	 Lightning Lake - Large Loop 	28	19
1503	Lightning Lake	 Lightning Lake - Large Loop 	29	19
1504	Lightning Lake	 Lightning Lake - Large Loop 	30	19
1505	Lightning Lake	 Lightning Lake - Large Loop 	31	19
1506	Lightning Lake	 Lightning Lake - Large Loop 	32	19
1507	Lightning Lake	 Lightning Lake - Large Loop 	33	19
1508	Lightning Lake	 Lightning Lake - Large Loop 	34	19
1509	Lightning Lake	 Lightning Lake - Large Loop 	35	19
1510	Lightning Lake	 Lightning Lake - Large Loop 	36	19
1511	Lightning Lake	 Lightning Lake - Large Loop 	37	19
1512	Lightning Lake	 Lightning Lake - Large Loop 	38	19
1513	Lightning Lake	 Lightning Lake - Large Loop 	39	19
1514	Lightning Lake	 Lightning Lake - Large Loop 	40	19
1515	Lightning Lake	 Lightning Lake - Large Loop 	41	19
1516	Lightning Lake	 Lightning Lake - Large Loop 	42	19
1517	Lightning Lake	 Lightning Lake - Large Loop 	43	19
1518	Lightning Lake	 Lightning Lake - Large Loop 	44	19
1519	Lightning Lake	 Lightning Lake - Large Loop 	45	19
1520	Lightning Lake	 Lightning Lake - Large Loop 	46	19
1521	Lightning Lake	 Lightning Lake - Large Loop 	47	19
1522	Lightning Lake	 Lightning Lake - Large Loop 	48	19
1523	Lightning Lake	 Lightning Lake - Large Loop 	49	19
1524	Lightning Lake	 Lightning Lake - Large Loop 	50	19
1525	Lightning Lake	 Lightning Lake - Large Loop 	51	19
1526	Lightning Lake	 Lightning Lake - Large Loop 	52	19
1527	Lightning Lake	 Lightning Lake - Large Loop 	53	19
1528	Lightning Lake	 Lightning Lake - Large Loop 	54	19
1529	Lightning Lake	 Lightning Lake - Large Loop 	55	19
1530	Lightning Lake	 Lightning Lake - Large Loop 	56	19
1531	Lightning Lake	 Lightning Lake - Large Loop 	57	19
1532	Lightning Lake	 Lightning Lake - Large Loop 	58	19
1533	Lightning Lake	 Lightning Lake - Large Loop 	59	19
1534	Lightning Lake	 Lightning Lake - Large Loop 	60	19
1535	Lightning Lake	 Lightning Lake - Large Loop 	61	19
1536	Lightning Lake	 Lightning Lake - Large Loop 	62	19
1537	Lightning Lake	 Lightning Lake - Large Loop 	63	19
1538	Lightning Lake	 Lightning Lake - Large Loop 	64	19
1539	Lightning Lake	 Lightning Lake - Large Loop 	65	19
1540	Lightning Lake	 Lightning Lake - Large Loop 	66	19
1541	Lightning Lake	 Lightning Lake - Large Loop 	67	19
1542	Lightning Lake	 Lightning Lake - Large Loop 	68	19
1543	Lightning Lake	 Lightning Lake - Large Loop 	69	19
1544	Lightning Lake	 Lightning Lake - Large Loop 	70	19
1545	Lightning Lake	 Lightning Lake - Large Loop 	71	19
1546	Lightning Lake	 Lightning Lake - Large Loop 	72	19
1547	Lightning Lake	 Lightning Lake - Large Loop 	73	19
1548	Lightning Lake	 Lightning Lake - Large Loop 	74	19
1549	Lightning Lake	 Lightning Lake - Large Loop 	75	19
1550	Lightning Lake	 Lightning Lake - Large Loop 	76	19
1551	Lightning Lake	 Lightning Lake - Large Loop 	77	19
1552	Lightning Lake	 Lightning Lake - Large Loop 	78	19
1553	Lightning Lake	 Lightning Lake - Large Loop 	79	19
1554	Lightning Lake	 Lightning Lake - Large Loop 	80	19
1555	Lightning Lake	 Lightning Lake - Large Loop 	81	19
1556	Lightning Lake	 Lightning Lake - Large Loop 	82	19
1557	Lightning Lake	 Lightning Lake - Large Loop 	83	19
1558	Lightning Lake	 Lightning Lake - Large Loop 	84	19
1559	Lightning Lake	 Lightning Lake - Large Loop 	85	19
1560	Lightning Lake	 Lightning Lake - Large Loop 	86	19
1561	Lightning Lake	 Lightning Lake - Large Loop 	87	19
1562	Lightning Lake	 Lightning Lake - Large Loop 	88	19
1563	Lightning Lake	 Lightning Lake - Large Loop 	89	19
1564	Lightning Lake	 Lightning Lake - Large Loop 	90	19
1565	Lightning Lake	 Lightning Lake - Large Loop 	91	19
1566	Lightning Lake	 Lightning Lake - Large Loop 	92	19
1567	Lightning Lake	 Lightning Lake B 	93	19
1568	Lightning Lake	 Lightning Lake B 	94	19
1569	Lightning Lake	 Lightning Lake B 	95	19
1570	Lightning Lake	 Lightning Lake B 	96	19
1571	Lightning Lake	 Lightning Lake B 	97	19
1572	Lightning Lake	 Lightning Lake B 	98	19
1573	Lightning Lake	 Lightning Lake B 	99	19
1574	Lightning Lake	 Lightning Lake B 	100	19
1575	Lightning Lake	 Lightning Lake B 	101	19
1576	Lightning Lake	 Lightning Lake B 	102	19
1577	Lightning Lake	 Lightning Lake B 	103	19
1578	Lightning Lake	 Lightning Lake B 	104	19
1579	Lightning Lake	 Lightning Lake B 	105	19
1580	Lightning Lake	 Lightning Lake B 	106	19
1581	Lightning Lake	 Lightning Lake B 	107	19
1582	Lightning Lake	 Lightning Lake B 	108	19
1583	Lightning Lake	 Lightning Lake B 	109	19
1584	Lightning Lake	 Lightning Lake B 	110	19
1585	Lightning Lake	 Lightning Lake B 	111	19
1586	Lightning Lake	 Lightning Lake B 	112	19
1587	Lightning Lake	 Lightning Lake B 	113	19
1588	Lightning Lake	 Lightning Lake B 	114	19
1589	Lightning Lake	 Lightning Lake B 	115	19
1590	Lightning Lake	 Lightning Lake B 	116	19
1591	Lightning Lake	 Lightning Lake B 	117	19
1592	Lightning Lake	 Lightning Lake B 	118	19
1593	Lightning Lake	 Lightning Lake B 	119	19
1594	Lightning Lake	 Lightning Lake B 	120	19
1595	Lightning Lake	 Lightning Lake B 	121	19
1596	Lightning Lake	 Lightning Lake B 	122	19
1597	Lightning Lake	 Lightning Lake B 	123	19
1598	Lightning Lake	 Lightning Lake B 	124	19
1599	Lightning Lake	 Lightning Lake B 	125	19
1600	Lightning Lake	 Lightning Lake B 	126	19
1601	Lightning Lake	 Lightning Lake B 	127	19
1602	Lightning Lake	 Lightning Lake B 	128	19
1603	Lightning Lake	 Lightning Lake B 	129	19
1604	Lightning Lake	 Lightning Lake B 	130	19
1605	Lightning Lake	 Lightning Lake B 	131	19
1606	Lightning Lake	 Lightning Lake B 	132	19
1607	Lightning Lake	 Lightning Lake B 	133	19
1608	Lightning Lake	 Lightning Lake B 	134	19
1609	Lightning Lake	 Lightning Lake B 	135	19
1610	Lightning Lake	 Lightning Lake B 	136	19
1611	Lightning Lake	 Lightning Lake B 	137	19
1612	Lightning Lake	 Lightning Lake B 	138	19
1613	Lightning Lake	 Lightning Lake B 	139	19
1614	Lightning Lake	 Lightning Lake B 	140	19
1615	Lightning Lake	 Lightning Lake B 	141	19
1616	Lightning Lake	 Lightning Lake B 	142	19
1617	Lightning Lake	 Lightning Lake B 	143	19
1618	Coldspring Campground	None	C1	19
1619	Coldspring Campground	None	C2	19
1620	Coldspring Campground	None	C3	19
1621	Coldspring Campground	None	C4	19
1622	Coldspring Campground	None	C5	19
1623	Coldspring Campground	None	C6	19
1624	Coldspring Campground	None	C7	19
1625	Coldspring Campground	None	C8	19
1626	Coldspring Campground	None	C9	19
1627	Coldspring Campground	None	C10	19
1628	Coldspring Campground	None	C11	19
1629	Coldspring Campground	None	C12	19
1630	Coldspring Campground	None	C13	19
1631	Coldspring Campground	None	C14	19
1632	Coldspring Campground	None	C15	19
1633	Coldspring Campground	None	C16	19
1634	Coldspring Campground	None	C17	19
1635	Coldspring Campground	None	C18	19
1636	Coldspring Campground	None	C19	19
1637	Coldspring Campground	None	C20	19
1638	Coldspring Campground	None	C21	19
1639	Coldspring Campground	None	C22	19
1640	Coldspring Campground	None	C23	19
1641	Coldspring Campground	None	C24	19
1642	Coldspring Campground	None	C25	19
1643	Coldspring Campground	None	C26	19
1644	Coldspring Campground	None	C27	19
1645	Coldspring Campground	None	C28	19
1646	Coldspring Campground	None	C29	19
1647	Coldspring Campground	None	C30	19
1648	Coldspring Campground	None	C31	19
1649	Coldspring Campground	None	C32	19
1650	Coldspring Campground	None	C33	19
1651	Coldspring Campground	None	C34	19
1652	Coldspring Campground	None	C35	19
1653	Coldspring Campground	None	C36	19
1654	Coldspring Campground	None	C37	19
1655	Coldspring Campground	None	C38	19
1656	Coldspring Campground	None	C39	19
1657	Coldspring Campground	None	C40	19
1658	Coldspring Campground	None	C41	19
1659	Coldspring Campground	None	C42	19
1660	Coldspring Campground	None	C43	19
1661	Coldspring Campground	None	C44	19
1662	Coldspring Campground	None	C45	19
1663	Coldspring Campground	None	C46	19
1664	Coldspring Campground	None	C47	19
1665	Coldspring Campground	None	C48	19
1666	Coldspring Campground	None	C49	19
1667	Coldspring Campground	None	C50	19
1668	Coldspring Campground	None	C51	19
1669	Coldspring Campground	None	C52	19
1670	Coldspring Campground	None	C53	19
1671	Coldspring Campground	None	C54	19
1672	Coldspring Campground	None	C55	19
1673	Coldspring Campground	None	C56	19
1674	Coldspring Campground	None	C57	19
1675	Coldspring Campground	None	C58	19
1676	Coldspring Campground	None	C59	19
1677	Coldspring Campground	None	C60	19
1678	Coldspring Campground	None	C61	19
1679	Coldspring Campground	None	C62	19
1680	Coldspring Campground	None	C63	19
1681	Coldspring Campground	None	C64	19
1682	Coldspring Campground	None	C65	19
1683	Coldspring Campground	None	C66	19
1684	Mule Deer Campground	None	M1	19
1685	Mule Deer Campground	None	M2	19
1686	Mule Deer Campground	None	M3	19
1687	Mule Deer Campground	None	M4	19
1688	Mule Deer Campground	None	M5	19
1689	Mule Deer Campground	None	M6	19
1690	Mule Deer Campground	None	M7	19
1691	Mule Deer Campground	None	M8	19
1692	Mule Deer Campground	None	M9	19
1693	Mule Deer Campground	None	M10	19
1694	Mule Deer Campground	None	M11	19
1695	Mule Deer Campground	None	M12	19
1696	Mule Deer Campground	None	M13	19
1697	Mule Deer Campground	None	M14	19
1698	Mule Deer Campground	None	M15	19
1699	Mule Deer Campground	None	M16a	19
1700	Mule Deer Campground	None	M16b	19
1701	Mule Deer Campground	None	M17	19
1702	Mule Deer Campground	None	M18	19
1703	Mule Deer Campground	None	M19	19
1704	Mule Deer Campground	None	M20	19
1705	Mule Deer Campground	None	M21	19
1706	Mule Deer Campground	None	M22	19
1707	Mule Deer Campground	None	M23	19
1708	Mule Deer Campground	None	M24	19
1709	Mule Deer Campground	None	M25	19
1710	Mule Deer Campground	None	M26	19
1711	Mule Deer Campground	None	M27	19
1712	Mule Deer Campground	None	M28	19
1713	Mule Deer Campground	None	M29	19
1714	Mule Deer Campground	None	M30	19
1715	Mule Deer Campground	None	M31	19
1716	Mule Deer Campground	None	M32	19
1717	Mule Deer Campground	None	M33	19
1718	Mule Deer Campground	None	M34	19
1719	Mule Deer Campground	None	M35	19
1720	Mule Deer Campground	None	M36	19
1721	Mule Deer Campground	None	M37	19
1722	Mule Deer Campground	None	M38	19
1723	Mule Deer Campground	None	M39	19
1724	Mule Deer Campground	None	M40	19
1725	Mule Deer Campground	None	M41	19
1726	Mule Deer Campground	None	M42	19
1727	Mule Deer Campground	None	M43	19
1728	Mule Deer Campground	None	M44	19
1729	Mule Deer Campground	None	M45	19
1730	Mule Deer Campground	None	M46	19
1731	Mule Deer Campground	None	M47	19
1732	Mule Deer Campground	None	M48	19
1733	Mule Deer Campground	None	M49	19
1734	Mule Deer Campground	None	M50	19
1735	Mule Deer Campground	None	M51	19
1736	Mule Deer Campground	None	M52	19
1737	Mule Deer Campground	None	M53	19
1738	Mule Deer Campground	None	M54	19
1739	Mule Deer Campground	None	M55	19
1740	Mule Deer Campground	None	M56	19
1741	Mule Deer Campground	None	M57	19
1742	Mule Deer Campground	None	M58	19
1743	Mule Deer Campground	None	M59	19
1744	Mule Deer Campground	None	M60	19
1745	Mule Deer Campground	None	M61	19
1746	Mule Deer Campground	None	M62	19
1747	Mule Deer Campground	None	M63	19
1748	Mule Deer Campground	None	M64	19
1749	Mule Deer Campground	None	M65	19
1750	Mule Deer Campground	None	M66	19
1751	Mule Deer Campground	None	M67	19
1752	Mule Deer Campground	None	M68	19
1753	Hampton Campground	None	H1	19
1754	Hampton Campground	None	H2	19
1755	Hampton Campground	None	H3	19
1756	Hampton Campground	None	H4	19
1757	Hampton Campground	None	H5	19
1758	Hampton Campground	None	H6	19
1759	Hampton Campground	None	H7	19
1760	Hampton Campground	None	H8	19
1761	Hampton Campground	None	H9	19
1762	Hampton Campground	None	H10	19
1763	Hampton Campground	None	H11	19
1764	Hampton Campground	None	H12	19
1765	Hampton Campground	None	H13	19
1766	Hampton Campground	None	H14	19
1767	Hampton Campground	None	H15	19
1768	Hampton Campground	None	H16	19
1769	Hampton Campground	None	H17	19
1770	Hampton Campground	None	H18	19
1771	Hampton Campground	None	H19	19
1772	Hampton Campground	None	H20	19
1773	Hampton Campground	None	H21	19
1774	Hampton Campground	None	H22	19
1775	Hampton Campground	None	H23	19
1776	Hampton Campground	None	H24	19
1777	Hampton Campground	None	H25	19
1778	Hampton Campground	None	H26	19
1779	Hampton Campground	None	H27	19
1780	Hampton Campground	None	H28	19
1781	Hampton Campground	None	H29	19
1782	Hampton Campground	None	H30	19
1783	Hampton Campground	None	H31	19
1784	Hampton Campground	None	H32	19
1785	Hampton Campground	None	H33	19
1786	Hampton Campground	None	H34	19
1787	Hampton Campground	None	H35	19
1788	Hampton Campground	None	H36	19
1789	Hampton Campground	None	H37	19
1790	Hampton Campground	None	H38	19
1791	Hampton Campground	None	H39	19
1792	Hampton Campground	None	H40	19
1793	Hampton Campground	None	H41	19
1794	Hampton Campground	None	H42	19
1795	Hampton Campground	None	H43	19
1796	Hampton Campground	None	H44	19
1797	Hampton Campground	None	H45	19
1798	Hampton Campground	None	H46	19
1799	Hampton Campground	None	H47	19
1800	Hampton Campground	None	H48	19
1801	Hampton Campground	None	H49	19
1802	Hampton Campground	None	H50	19
1803	Hampton Campground	None	H51	19
1804	Hampton Campground	None	H52	19
1805	Hampton Campground	None	H53	19
1806	Hampton Campground	None	H54	19
1807	Hampton Campground	None	H55	19
1808	Hampton Campground	None	H56	19
1809	Hampton Campground	None	H57	19
1810	Hampton Campground	None	H58	19
1811	Hampton Campground	None	H59	19
1812	Hampton Campground	None	H60	19
1813	Hampton Campground	None	H61	19
1814	Hampton Campground	None	H62	19
1815	Hampton Campground	None	H63	19
1816	Hampton Campground	None	H64	19
1817	Hampton Campground	None	H65	19
1818	Hampton Campground	None	H66	19
1819	Hampton Campground	None	H67	19
1820	Hampton Campground	None	H68	19
1821	Hampton Campground	None	H69	19
1822	Hampton Campground	None	H70	19
1823	Hampton Campground	None	H71	19
1824	Hampton Campground	None	H72	19
1825	Hampton Campground	None	H73	19
1826	Hampton Campground	None	H74	19
1827	Hampton Campground	None	H75	19
1828	Hampton Campground	None	H76	19
1829	Hampton Campground	None	H77	19
1830	Hampton Campground	None	H78	19
1831	Hampton Campground	None	H79	19
1832	Hampton Campground	None	H80	19
1833	Hampton Campground	None	H81	19
1834	Hampton Campground	None	H82	19
1835	Hampton Campground	None	H83	19
1836	Hampton Campground	None	H84	19
1837	Hampton Campground	None	H85	19
1838	Hampton Campground	None	H86	19
1839	Hampton Campground	None	H87	19
1840	Hampton Campground	None	H88	19
1841	Hampton Campground	None	H89	19
1842	Hampton Campground	None	H90	19
1843	Hampton Campground	None	H91	19
1844	Hampton Campground	None	H92	19
1845	Hampton Campground	None	H93	19
1846	Hampton Campground	None	H94	19
1847	Hampton Campground	None	H95	19
1848	Hampton Campground	None	H96	19
1849	Hampton Campground	None	H97	19
1850	Hampton Campground	None	H98	19
1851	Hampton Campground	None	H99	19
1852	Hampton Campground	None	H100	19
1853	Group Sites	None	G1 - Lone Duck 1	19
1854	Group Sites	None	G2 - Lone Duck 2	19
1855	Group Sites	None	G3 - Cambie Creek	19
1856	Campground	None	1	20
1857	Campground	None	2	20
1858	Campground	None	3	20
1859	Campground	None	4	20
1860	Campground	None	5	20
1861	Campground	None	6	20
1862	Campground	None	7	20
1863	Campground	None	8	20
1864	Campground	None	9	20
1865	Campground	None	10	20
1866	Campground	None	11	20
1867	Campground	None	12	20
1868	Campground	None	13	20
1869	Campground	None	14	20
1870	Campground	None	15	20
1871	Campground	None	16	20
1872	Campground	None	17	20
1873	Campground	None	18	20
1874	Campground	None	19	20
1875	Campground	None	20	20
1876	Campground	None	21	20
1877	Campground	None	22	20
1878	Campground	None	23	20
1879	Campground	None	24	20
1880	Campground	None	25	20
1881	Campground	None	26	20
1882	Campground	None	27	20
1883	Campground	None	28	20
1884	Campground	None	29	20
1885	Campground	None	30	20
1886	Campground	None	31	20
1887	Campground	None	32	20
1888	Campground	None	33	20
1889	Campground	None	34	20
1890	Campground	None	35	20
1891	Campground	None	36	20
1892	Campground	None	37	20
1893	Campground	None	38	20
1894	Campground	None	39	20
1895	Campground	None	40	20
1896	Campground	None	41	20
1897	Campground	None	42	20
1898	Campground	None	43	20
1899	Campground	None	44	20
1900	Campground	None	45	20
1901	Campground	None	46	20
1902	Campground	None	47	20
1903	Campground	None	48	20
1904	Campground	None	49	20
1905	Campground	None	50	20
1906	Campground	None	51	20
1907	Campground	None	52	20
1908	Campground	None	53	20
1909	Campground	None	54	20
1910	Campground	None	55	20
1911	Campground	None	56	20
1912	Campground	None	57	20
1913	Campground	None	58	20
1914	Campground	None	59	20
1915	Campground	None	60	20
1916	Campground	None	61	20
1917	Campground	None	62	20
1918	Campground	None	63	20
1919	Campground	None	64	20
1920	Campground	None	65	20
1921	Campground	None	66	20
1922	Campground	None	67	20
1923	Campground	None	68	20
1924	Campground	None	69	20
1925	Campground	None	70	20
1926	Campground	None	71	20
1927	Campground	None	72	20
1928	Campground	None	73	20
1929	Campground	None	74	20
1930	Campground	None	75	20
1931	Campground	None	76	20
1932	Campground	None	77	20
1933	Campground	None	78	20
1934	Campground	None	79	20
1935	Campground	None	80	20
1936	Campground	None	81	20
1937	Campground	None	82	20
1938	Campground	None	83	20
1939	Campground	None	84	20
1940	Campground	None	85	20
1941	Campground	None	86	20
1942	Campground	None	87	20
1943	Campground	None	88	20
1944	Campground	None	89	20
1945	Campground	None	90	20
1946	Campground	None	91	20
1947	Campground	None	92	20
1948	Campground	None	93	20
1949	Campground	None	94	20
1950	Campground	None	95	20
1951	Campground	None	96	20
1952	Campground	None	97	20
1953	Campground	None	98	20
1954	Campground	None	99	20
1955	Campground	None	100	20
1956	Campground	None	101	20
1957	Campground	None	102	20
1958	Campground	None	103	20
1959	Campground	None	104	20
1960	Campground	None	105	20
1961	Campground	None	106	20
1962	Campground	None	107	20
1963	Campground	None	108	20
1964	Campground	None	109	20
1965	Campground	None	110	20
1966	Campground	None	111	20
1967	Campground	None	112	20
1968	Campground	None	113	20
1969	Campground	None	114	20
1970	Campground	None	115	20
1971	Campground	None	116	20
1972	Campground	None	117	20
1973	Campground	None	118	20
1974	Campground	None	119	20
1975	Campground	None	120	20
1976	Campground	None	121	20
1977	Campground	None	122	20
1978	Campground	None	1	21
1979	Campground	None	2	21
1980	Campground	None	3	21
1981	Campground	None	4	21
1982	Campground	None	5	21
1983	Campground	None	6	21
1984	Campground	None	7	21
1985	Campground	None	8	21
1986	Campground	None	9	21
1987	Campground	None	10	21
1988	Campground	None	11	21
1989	Campground	None	12	21
1990	Campground	None	13	21
1991	Campground	None	14	21
1992	Campground	None	15	21
1993	Campground	None	16	21
1994	Campground	None	17	21
1995	Campground	None	18	21
1996	Campground	None	19	21
1997	Campground	None	20	21
1998	Campground	None	21	21
1999	Campground	None	22	21
2000	Campground	None	23	21
2001	Campground	None	24	21
2002	Campground	None	25	21
2003	Campground	None	26	21
2004	Campground	None	27	21
2005	Campground	None	28	21
2006	Campground	None	29	21
2007	Campground	None	30	21
2008	Campground	None	31	21
2009	Campground	None	32	21
2010	Campground	None	33	21
2011	Campground	None	34	21
2012	Campground	None	35	21
2013	Campground	None	36	21
2014	Campground	None	37	21
2015	Campground	None	38	21
2016	Campground	None	39	21
2017	Campground	None	40	21
2018	Campground	None	41	21
2019	Campground	None	42	21
2020	Campground	None	43	21
2021	Campground	None	44	21
2022	Campground	None	45	21
2023	Campground	None	46	21
2024	Campground	None	47	21
2025	Campground	None	48	21
2026	Campground	None	49	21
2027	Campground	None	50	21
2028	Campground	None	51	21
2029	Campground	None	52	21
2030	Campground	None	53	21
2031	Campground	None	54	21
2032	Campground	None	55	21
2033	Campground	None	56	21
2034	Campground	None	57	21
2035	Campground	None	58	21
2036	Campground	None	59	21
2037	Campground	None	60	21
2038	Campground	None	61	21
2039	Campground	None	62	21
2040	Campground	None	63	21
2041	Campground	None	64	21
2042	Campground	None	65	21
2043	Campground	None	66	21
2044	Campground	None	67	21
2045	Campground	None	68	21
2046	Campground	None	69	21
2047	Campground	None	70	21
2048	Campground	None	71	21
2049	None	None	1	22
2050	None	None	2	22
2051	None	None	3	22
2052	None	None	4	22
2053	None	None	5	22
2054	None	None	6	22
2055	None	None	7	22
2056	None	None	8	22
2057	None	None	9	22
2058	None	None	10	22
2059	None	None	11	22
2060	None	None	12	22
2061	None	None	13	22
2062	None	None	14	22
2063	None	None	15	22
2064	None	None	16	22
2065	None	None	17	22
2066	None	None	18	22
2067	None	None	19	22
2068	None	None	20	22
2069	None	None	21	22
2070	None	None	22	22
2071	None	None	23	22
2072	None	None	24	22
2073	None	None	25	22
2074	None	None	26	22
2075	None	None	26A	22
2076	None	None	27	22
2077	None	None	28	22
2078	None	None	28A	22
2079	None	None	29	22
2080	None	None	30	22
2081	None	None	31	22
2082	None	None	32	22
2083	None	None	33	22
2084	None	None	34	22
2085	None	None	35	22
2086	None	None	36	22
2087	None	None	37	22
2088	None	None	38	22
2089	None	None	39	22
2090	None	None	40	22
2091	None	None	41	22
2092	None	None	42	22
2093	None	None	43	22
2094	None	None	44	22
2095	None	None	45	22
2096	None	None	46	22
2097	None	None	47	22
2098	None	None	48	22
2099	None	None	49	22
2100	None	None	50	22
2101	None	None	51	22
2102	None	None	52	22
2103	None	None	53	22
2104	None	None	54	22
2105	None	None	55	22
2106	None	None	56	22
2107	None	None	57	22
2108	None	None	58	22
2109	None	None	59	22
2110	None	None	60	22
2111	None	None	61	22
2112	None	None	62	22
2113	None	None	63	22
2114	None	None	64	22
2115	None	None	65	22
2116	None	None	66	22
2117	None	None	67	22
2118	None	None	68	22
2119	None	None	69	22
2120	None	None	70	22
2121	None	None	71	22
2122	None	None	72	22
2123	None	None	73	22
2124	None	None	74	22
2125	None	None	75	22
2126	None	None	76	22
2127	None	None	77	22
2128	None	None	78	22
2129	None	None	79	22
2130	None	None	80	22
2131	None	None	81	22
2132	None	None	82	22
2133	None	None	83	22
2134	None	None	84	22
2135	None	None	85	22
2136	None	None	86	22
2137	None	None	87	22
2138	None	None	88	22
2139	None	None	89	22
2140	None	None	90	22
2141	None	None	91	22
2142	None	None	92	22
2143	None	None	93	22
2144	None	None	94	22
2145	None	None	95	22
2146	None	None	96	22
2147	None	None	97	22
2148	None	None	98	22
2149	None	None	99	22
2150	None	None	100	22
2151	None	None	101	22
2152	None	None	102	22
2153	None	None	103	22
2154	Campground	None	1	23
2155	Campground	None	2	23
2156	Campground	None	3	23
2157	Campground	None	4	23
2158	Campground	None	5	23
2159	Campground	None	6	23
2160	Campground	None	7	23
2161	Campground	None	8	23
2162	Campground	None	9	23
2163	Campground	None	10	23
2164	A (Sites 1-50)	None	1	24
2165	A (Sites 1-50)	None	2	24
2166	A (Sites 1-50)	None	3	24
2167	A (Sites 1-50)	None	4	24
2168	A (Sites 1-50)	None	5	24
2169	A (Sites 1-50)	None	6	24
2170	A (Sites 1-50)	None	7	24
2171	A (Sites 1-50)	None	8	24
2172	A (Sites 1-50)	None	9	24
2173	A (Sites 1-50)	None	10	24
2174	A (Sites 1-50)	None	11	24
2175	A (Sites 1-50)	None	12	24
2176	A (Sites 1-50)	None	13	24
2177	A (Sites 1-50)	None	14	24
2178	A (Sites 1-50)	None	15	24
2179	A (Sites 1-50)	None	16	24
2180	A (Sites 1-50)	None	17	24
2181	A (Sites 1-50)	None	18	24
2182	A (Sites 1-50)	None	19	24
2183	A (Sites 1-50)	None	20	24
2184	A (Sites 1-50)	None	21	24
2185	A (Sites 1-50)	None	22	24
2186	A (Sites 1-50)	None	23	24
2187	A (Sites 1-50)	None	24	24
2188	A (Sites 1-50)	None	25	24
2189	A (Sites 1-50)	None	26	24
2190	A (Sites 1-50)	None	27	24
2191	A (Sites 1-50)	None	28	24
2192	A (Sites 1-50)	None	29	24
2193	A (Sites 1-50)	None	30	24
2194	A (Sites 1-50)	None	31	24
2195	A (Sites 1-50)	None	32	24
2196	A (Sites 1-50)	None	33	24
2197	A (Sites 1-50)	None	34	24
2198	A (Sites 1-50)	None	35	24
2199	A (Sites 1-50)	None	36	24
2200	A (Sites 1-50)	None	37	24
2201	A (Sites 1-50)	None	38	24
2202	A (Sites 1-50)	None	39	24
2203	A (Sites 1-50)	None	40	24
2204	A (Sites 1-50)	None	41	24
2205	A (Sites 1-50)	None	42	24
2206	A (Sites 1-50)	None	43	24
2207	A (Sites 1-50)	None	44	24
2208	A (Sites 1-50)	None	45	24
2209	A (Sites 1-50)	None	46	24
2210	A (Sites 1-50)	None	47	24
2211	A (Sites 1-50)	None	48	24
2212	A (Sites 1-50)	None	49	24
2213	B (Sites 50-83)	None	51	24
2214	B (Sites 50-83)	None	52	24
2215	B (Sites 50-83)	None	53	24
2216	B (Sites 50-83)	None	54	24
2217	B (Sites 50-83)	None	55	24
2218	B (Sites 50-83)	None	56	24
2219	B (Sites 50-83)	None	57	24
2220	B (Sites 50-83)	None	58	24
2221	B (Sites 50-83)	None	59	24
2222	B (Sites 50-83)	None	60	24
2223	B (Sites 50-83)	None	61	24
2224	B (Sites 50-83)	None	62	24
2225	B (Sites 50-83)	None	63	24
2226	B (Sites 50-83)	None	64	24
2227	B (Sites 50-83)	None	65	24
2228	B (Sites 50-83)	None	66	24
2229	B (Sites 50-83)	None	67	24
2230	B (Sites 50-83)	None	68	24
2231	B (Sites 50-83)	None	69	24
2232	B (Sites 50-83)	None	70	24
2233	B (Sites 50-83)	None	71	24
2234	B (Sites 50-83)	None	72	24
2235	B (Sites 50-83)	None	73	24
2236	B (Sites 50-83)	None	74	24
2237	B (Sites 50-83)	None	75	24
2238	B (Sites 50-83)	None	76	24
2239	B (Sites 50-83)	None	77	24
2240	B (Sites 50-83)	None	78	24
2241	B (Sites 50-83)	None	79	24
2242	B (Sites 50-83)	None	80	24
2243	B (Sites 50-83)	None	81	24
2244	B (Sites 50-83)	None	82	24
2245	C (Sites 83-110)	None	83	24
2246	C (Sites 83-110)	None	84	24
2247	C (Sites 83-110)	None	85	24
2248	C (Sites 83-110)	None	86	24
2249	C (Sites 83-110)	None	87	24
2250	C (Sites 83-110)	None	88	24
2251	C (Sites 83-110)	None	89	24
2252	C (Sites 83-110)	None	90	24
2253	C (Sites 83-110)	None	91	24
2254	C (Sites 83-110)	None	92	24
2255	C (Sites 83-110)	None	93	24
2256	C (Sites 83-110)	None	94	24
2257	C (Sites 83-110)	None	95	24
2258	C (Sites 83-110)	None	96	24
2259	C (Sites 83-110)	None	97	24
2260	C (Sites 83-110)	None	98	24
2261	C (Sites 83-110)	None	99	24
2262	C (Sites 83-110)	None	100	24
2263	C (Sites 83-110)	None	101	24
2264	C (Sites 83-110)	None	102	24
2265	C (Sites 83-110)	None	103	24
2266	C (Sites 83-110)	None	104	24
2267	C (Sites 83-110)	None	105	24
2268	C (Sites 83-110)	None	106	24
2269	C (Sites 83-110)	None	107	24
2270	C (Sites 83-110)	None	108	24
2271	C (Sites 83-110)	None	109	24
2272	C (Sites 83-110)	None	110	24
2273	D (Sites 111-160)	None	111	24
2274	D (Sites 111-160)	None	112	24
2275	D (Sites 111-160)	None	113	24
2276	D (Sites 111-160)	None	114	24
2277	D (Sites 111-160)	None	115	24
2278	D (Sites 111-160)	None	116	24
2279	D (Sites 111-160)	None	117	24
2280	D (Sites 111-160)	None	118	24
2281	D (Sites 111-160)	None	119	24
2282	D (Sites 111-160)	None	120	24
2283	D (Sites 111-160)	None	121	24
2284	D (Sites 111-160)	None	122	24
2285	D (Sites 111-160)	None	123	24
2286	D (Sites 111-160)	None	124	24
2287	D (Sites 111-160)	None	125	24
2288	D (Sites 111-160)	None	126	24
2289	D (Sites 111-160)	None	127	24
2290	D (Sites 111-160)	None	128	24
2291	D (Sites 111-160)	None	129	24
2292	D (Sites 111-160)	None	130	24
2293	D (Sites 111-160)	None	131	24
2294	D (Sites 111-160)	None	132	24
2295	D (Sites 111-160)	None	133	24
2296	D (Sites 111-160)	None	134	24
2297	D (Sites 111-160)	None	135	24
2298	D (Sites 111-160)	None	136	24
2299	D (Sites 111-160)	None	137	24
2300	D (Sites 111-160)	None	138	24
2301	D (Sites 111-160)	None	139	24
2302	D (Sites 111-160)	None	140	24
2303	D (Sites 111-160)	None	141	24
2304	D (Sites 111-160)	None	142	24
2305	D (Sites 111-160)	None	143	24
2306	D (Sites 111-160)	None	144	24
2307	D (Sites 111-160)	None	145	24
2308	D (Sites 111-160)	None	146	24
2309	D (Sites 111-160)	None	147	24
2310	D (Sites 111-160)	None	148	24
2311	D (Sites 111-160)	None	149	24
2312	D (Sites 111-160)	None	150	24
2313	D (Sites 111-160)	None	151	24
2314	D (Sites 111-160)	None	152	24
2315	D (Sites 111-160)	None	153	24
2316	D (Sites 111-160)	None	154	24
2317	D (Sites 111-160)	None	155	24
2318	D (Sites 111-160)	None	156	24
2319	D (Sites 111-160)	None	157	24
2320	D (Sites 111-160)	None	158	24
2321	D (Sites 111-160)	None	159	24
2322	D (Sites 111-160)	None	160	24
2323	Group Sites	None	G1 - Group Pod 1	24
2324	Group Sites	None	G2 - Group Pod 2	24
2325	Campground	None	1	25
2326	Campground	None	2	25
2327	Campground	None	3	25
2328	Campground	None	4	25
2329	Campground	None	5	25
2330	Campground	None	6	25
2331	Campground	None	7	25
2332	Campground	None	8	25
2333	Campground	None	9	25
2334	Campground	None	10	25
2335	Campground	None	11	25
2336	Campground	None	12	25
2337	Campground	None	13	25
2338	Campground	None	14	25
2339	Campground	None	15	25
2340	Campground	None	16	25
2341	Campground	None	17	25
2342	Campground	None	18	25
2343	Campground	None	19	25
2344	Campground	None	20	25
2345	Campground	None	21	25
2346	Campground	None	22	25
2347	Campground	None	23	25
2348	Campground	None	24	25
2349	Campground	None	25	25
2350	Campground	None	26	25
2351	Campground	None	27	25
2352	Campground	None	28	25
2353	Campground	None	29	25
2354	Campground	None	30	25
2355	Campground	None	31	25
2356	Campground	None	32	25
2357	Campground	None	33	25
2358	Campground	None	34	25
2359	Campground	None	35	25
2360	Campground	None	36	25
2361	Campground	None	37	25
2362	Campground	None	38	25
2363	Campground	None	39	25
2364	Campground	None	40	25
2365	Campground	None	41	25
2366	Campground	None	42	25
2367	Campground	None	43	25
2368	Campground	None	44	25
2369	Campground	None	45	25
2370	Campground	None	46	25
2371	Campground	None	47	25
2372	Campground	None	48	25
2373	Campground	None	49	25
2374	Campground	None	50	25
2375	Campground	None	51	25
2376	Campground	None	52	25
2377	Campground	None	53	25
2378	Campground	None	54	25
2379	Campground	None	55	25
2380	Campground	None	56	25
2381	Campground	None	57	25
2382	Campground	None	58	25
2383	Campground	None	59	25
2384	Campground	None	60	25
2385	Campground	None	61	25
2386	Campground	None	62	25
2387	Campground	None	63	25
2388	Campground	None	64	25
2389	Campground	None	65	25
2390	Campground	None	66	25
2391	Campground	None	67	25
2392	Campground	None	68	25
2393	Campground	None	69	25
2394	Group Sites	None	G1	25
2395	None	None	1	26
2396	None	None	2	26
2397	None	None	3	26
2398	None	None	4	26
2399	None	None	5	26
2400	None	None	6	26
2401	None	None	7	26
2402	None	None	8	26
2403	None	None	9	26
2404	None	None	10	26
2405	None	None	11	26
2406	None	None	12	26
2407	None	None	13	26
2408	None	None	14	26
2409	None	None	15	26
2410	None	None	16	26
2411	None	None	17	26
2412	None	None	18	26
2413	None	None	19	26
2414	None	None	20	26
2415	None	None	21	26
2416	None	None	22	26
2417	None	None	23	26
2418	None	None	24	26
2419	None	None	25	26
2420	None	None	26	26
2421	None	None	27	26
2422	None	None	28	26
2423	None	None	29	26
2424	None	None	30	26
2425	None	None	31	26
2426	None	None	32	26
2427	None	None	33	26
2428	None	None	34	26
2429	None	None	35	26
2430	None	None	36	26
2431	None	None	37	26
2432	None	None	38	26
2433	None	None	39	26
2434	None	None	40	26
2435	None	None	41	26
2436	None	None	42	26
2437	None	None	43	26
2438	None	None	44	26
2439	None	None	45	26
2440	None	None	46	26
2441	None	None	47	26
2442	None	None	48	26
2443	None	None	49	26
2444	None	None	50	26
2445	None	None	51	26
2446	None	None	52	26
2447	None	None	53	26
2448	None	None	54	26
2449	None	None	55	26
2450	None	None	56	26
2451	None	None	57	26
2452	None	None	58	26
2453	None	None	59	26
2454	None	None	60	26
2455	None	None	61	26
2456	None	None	62	26
2457	None	None	63	26
2458	North Beach	None	A3	27
2459	North Beach	None	A4	27
2460	North Beach	None	A5	27
2461	North Beach	None	A6	27
2462	North Beach	None	A7	27
2463	North Beach	None	A8	27
2464	North Beach	None	A9	27
2465	North Beach	None	A10	27
2466	North Beach	None	A11	27
2467	North Beach	None	A12	27
2468	North Beach	None	A13	27
2469	North Beach	None	A14	27
2470	North Beach	None	A15	27
2471	North Beach	None	A16	27
2472	North Beach	None	A17	27
2473	North Beach	None	A18	27
2474	North Beach	None	A19	27
2475	North Beach	None	A68	27
2476	North Beach	None	A69	27
2477	North Beach	None	A70	27
2478	North Beach	None	A71	27
2479	North Beach	None	A72	27
2480	North Beach	None	A73	27
2481	North Beach	None	A74	27
2482	North Beach	None	A75	27
2483	North Beach	None	A76	27
2484	North Beach	None	A77	27
2485	North Beach	None	A78	27
2486	North Beach	None	A79	27
2487	North Beach	None	A80	27
2488	North Beach	None	A81	27
2489	North Beach	None	A82	27
2490	North Beach	None	A83	27
2491	North Beach	None	A84	27
2492	North Beach	None	A85	27
2493	North Beach	None	A86	27
2494	North Beach	None	A87	27
2495	North Beach	None	A88	27
2496	North Beach	None	A89	27
2497	North Beach	None	A90	27
2498	North Beach	None	A91	27
2499	North Beach	None	A92	27
2500	North Beach	None	A93	27
2501	North Beach	None	A94	27
2502	North Beach	None	A95	27
2503	North Beach	None	A96	27
2504	North Beach	None	A97	27
2505	Alouette North	None	B1	27
2506	Alouette North	None	B2	27
2507	Alouette North	None	B3	27
2508	Alouette North	None	B4	27
2509	Alouette North	None	B5	27
2510	Alouette North	None	B6	27
2511	Alouette North	None	B7	27
2512	Alouette North	None	B8	27
2513	Alouette North	None	B9	27
2514	Alouette North	None	B10	27
2515	Alouette North	None	B11	27
2516	Alouette North	None	B12	27
2517	Alouette North	None	B13	27
2518	Alouette North	None	B14	27
2519	Alouette North	None	B15	27
2520	Alouette North	None	C18	27
2521	Alouette North	None	C19	27
2522	Alouette North	None	C20	27
2523	Alouette North	None	C21	27
2524	Alouette North	None	C22	27
2525	Alouette North	None	C23	27
2526	Alouette North	None	C24	27
2527	Alouette North	None	C25	27
2528	Alouette North	None	C26	27
2529	Alouette North	None	C27	27
2530	Alouette North	None	C28	27
2531	Alouette North	None	C29	27
2532	Alouette North	None	C30	27
2533	Alouette North	None	C31	27
2534	Alouette North	None	C32	27
2535	Alouette North	None	C33	27
2536	Alouette North	None	D18	27
2537	Alouette North	None	D19	27
2538	Alouette North	None	D20	27
2539	Alouette North	None	D21	27
2540	Alouette North	None	D22	27
2541	Alouette South	None	D23	27
2542	Alouette South	None	D24	27
2543	Alouette South	None	D25	27
2544	Alouette South	None	D26	27
2545	Alouette South	None	D27	27
2546	Alouette South	None	D28	27
2547	Alouette South	None	D29	27
2548	Alouette South	None	D30	27
2549	Alouette South	None	D31	27
2550	Alouette South	None	D32	27
2551	Alouette South	None	D33	27
2552	Alouette South	None	A20	27
2553	Alouette South	None	A21	27
2554	Alouette South	None	A22	27
2555	Alouette South	None	A23	27
2556	Alouette South	None	A24	27
2557	Alouette South	None	A25	27
2558	Alouette South	None	A26	27
2559	Alouette South	None	A27	27
2560	Alouette South	None	A28	27
2561	Alouette South	None	A29	27
2562	Alouette South	None	A30	27
2563	Alouette South	None	A31	27
2564	Alouette South	None	A32	27
2565	Alouette South	None	A33	27
2566	Alouette South	None	A34	27
2567	Alouette South	None	A35	27
2568	Alouette South	None	A36	27
2569	Alouette South	None	A37	27
2570	Alouette South	None	A38	27
2571	Alouette South	None	A39	27
2572	Alouette South	None	A40	27
2573	Alouette South	None	A41	27
2574	Alouette South	None	A42	27
2575	Alouette South	None	A43	27
2576	Alouette South	None	A44	27
2577	Alouette South	None	A45	27
2578	Alouette South	None	A46A	27
2579	Alouette South	None	A46B	27
2580	Alouette South	None	A47	27
2581	Alouette South	None	A48	27
2582	Alouette South	None	A49	27
2583	Alouette South	None	A50	27
2584	Alouette South	None	A51	27
2585	Alouette South	None	A52	27
2586	Alouette South	None	A53	27
2587	Alouette South	None	A54	27
2588	Alouette South	None	A55	27
2589	Alouette South	None	A56	27
2590	Alouette South	None	A57	27
2591	Alouette South	None	A58	27
2592	Alouette South	None	A59	27
2593	Alouette South	None	A60	27
2594	Alouette South	None	A61	27
2595	Alouette South	None	A62	27
2596	Alouette South	None	A63	27
2597	Alouette South	None	A64	27
2598	Alouette South	None	A65	27
2599	Alouette South	None	A66	27
2600	Alouette South	None	A67	27
2601	Alouette South	None	B16	27
2602	Alouette South	None	B17	27
2603	Alouette South	None	B18	27
2604	Alouette South	None	B19	27
2605	Alouette South	None	B20	27
2606	Alouette South	None	B21	27
2607	Alouette South	None	B22	27
2608	Alouette South	None	B23	27
2609	Alouette South	None	B24	27
2610	Alouette South	None	B25	27
2611	Alouette South	None	B26	27
2612	Alouette South	None	B27	27
2613	Alouette South	None	B28	27
2614	Alouette South	None	B29	27
2615	Alouette South	None	B30	27
2616	Alouette South	None	B31	27
2617	Alouette South	None	B32	27
2618	Alouette South	None	B33	27
2619	Alouette South	None	B34	27
2620	Alouette South	None	B35	27
2621	Alouette South	None	C1	27
2622	Alouette South	None	C2	27
2623	Alouette South	None	C3	27
2624	Alouette South	None	C4	27
2625	Alouette South	None	C5	27
2626	Alouette South	None	C6	27
2627	Alouette South	None	C7	27
2628	Alouette South	None	C8	27
2629	Alouette South	None	C9	27
2630	Alouette South	None	C10	27
2631	Alouette South	None	C11	27
2632	Alouette South	None	C12	27
2633	Alouette South	None	C13	27
2634	Alouette South	None	C14	27
2635	Alouette South	None	C15	27
2636	Alouette South	None	C16	27
2637	Alouette South	None	C17	27
2638	Alouette South	None	D23	27
2639	Alouette South	None	D24	27
2640	Alouette South	None	D25	27
2641	Alouette South	None	D26	27
2642	Alouette South	None	D27	27
2643	Alouette South	None	D28	27
2644	Alouette South	None	D29	27
2645	Alouette South	None	D30	27
2646	Alouette South	None	D31	27
2647	Alouette South	None	D32	27
2648	Alouette South	None	D33	27
2649	Alouette South	None	D34	27
2650	Alouette South	None	D35	27
2651	Alouette South	None	D36	27
2652	Alouette South	None	D37	27
2653	Alouette South	None	D38	27
2654	Alouette South	None	D39	27
2655	Gold Creek	None	Co1	27
2656	Gold Creek	None	Co2	27
2657	Gold Creek	None	Co3	27
2658	Gold Creek	None	Co4	27
2659	Gold Creek	None	Co5	27
2660	Gold Creek	None	Co6	27
2661	Gold Creek	None	Co7	27
2662	Gold Creek	None	Co8	27
2663	Gold Creek	None	Co9	27
2664	Gold Creek	None	Co10	27
2665	Gold Creek	None	Co11	27
2666	Gold Creek	None	Co12	27
2667	Gold Creek	None	Co13	27
2668	Gold Creek	None	Co14	27
2669	Gold Creek	None	Co15	27
2670	Gold Creek	None	K1	27
2671	Gold Creek	None	K2	27
2672	Gold Creek	None	K2A	27
2673	Gold Creek	None	K3	27
2674	Gold Creek	None	K4	27
2675	Gold Creek	None	K5	27
2676	Gold Creek	None	K6	27
2677	Gold Creek	None	K7	27
2678	Gold Creek	None	K8	27
2679	Gold Creek	None	K9	27
2680	Gold Creek	None	K9A	27
2681	Gold Creek	None	K10	27
2682	Gold Creek	None	K11	27
2683	Gold Creek	None	K12	27
2684	Gold Creek	None	M1	27
2685	Gold Creek	None	M2	27
2686	Gold Creek	None	M3	27
2687	Gold Creek	None	M4	27
2688	Gold Creek	None	M5	27
2689	Gold Creek	None	M6	27
2690	Gold Creek	None	M7	27
2691	Gold Creek	None	M8	27
2692	Gold Creek	None	M9	27
2693	Gold Creek	None	M9A	27
2694	Gold Creek	None	M10	27
2695	Gold Creek	None	M11	27
2696	Gold Creek	None	M12	27
2697	Gold Creek	None	P2	27
2698	Gold Creek	None	P3	27
2699	Gold Creek	None	P4	27
2700	Gold Creek	None	P5	27
2701	Gold Creek	None	P6	27
2702	Gold Creek	None	P7	27
2703	Gold Creek	None	P8	27
2704	Gold Creek	None	P9	27
2705	Gold Creek	None	S1	27
2706	Gold Creek	None	S2	27
2707	Gold Creek	None	S3	27
2708	Gold Creek	None	S4	27
2709	Gold Creek	None	S5	27
2710	Gold Creek	None	S6	27
2711	Gold Creek	None	S7	27
2712	Gold Creek	None	S8	27
2713	Gold Creek	None	S9	27
2714	Gold Creek	None	S10	27
2715	Gold Creek	None	S11	27
2716	Gold Creek	None	S12	27
2717	Gold Creek	None	S13	27
2718	Gold Creek	None	SP1	27
2719	Gold Creek	None	SP2	27
2720	Gold Creek	None	SP3	27
2721	Gold Creek	None	SP4	27
2722	Gold Creek	None	SP5	27
2723	Gold Creek	None	TD1	27
2724	Gold Creek	None	TD2	27
2725	Gold Creek	None	TD3	27
2726	Gold Creek	None	TD4	27
2727	Gold Creek	None	TD4A	27
2728	Gold Creek	None	TD4B	27
2729	Gold Creek	None	TD5	27
2730	Gold Creek	None	TD6	27
2731	Gold Creek	None	TD7	27
2732	Gold Creek	None	TD8	27
2733	Gold Creek	None	TD9	27
2734	Gold Creek	None	TD10	27
2735	Gold Creek	None	TD11	27
2736	Gold Creek	None	TD12	27
2737	Gold Creek	None	TD13	27
2738	Gold Creek	None	TD14	27
2739	Gold Creek	None	TD14A	27
2740	Gold Creek	None	TD15	27
2741	Gold Creek	None	TD16	27
2742	Gold Creek	None	TD17	27
2743	Gold Creek	None	TD18	27
2744	Gold Creek	None	TD19	27
2745	Gold Creek	None	TD20	27
2746	Gold Creek	None	TD21	27
2747	Gold Creek	None	TD21A	27
2748	Gold Creek	None	TD21B	27
2749	Gold Creek	None	TD24A	27
2750	Gold Creek	None	TD24B	27
2751	Gold Creek	None	F1	27
2752	Gold Creek	None	F2	27
2753	Gold Creek	None	F3	27
2754	Gold Creek	None	F4	27
2755	Gold Creek	None	F5	27
2756	Gold Creek	None	F6	27
2757	Gold Creek	None	F7	27
2758	Gold Creek	None	F8	27
2759	Gold Creek	None	H1	27
2760	Gold Creek	None	H2	27
2761	Gold Creek	None	H3	27
2762	Gold Creek	None	H4	27
2763	Gold Creek	None	H5	27
2764	Gold Creek	None	H6	27
2765	Gold Creek	None	H7	27
2766	Gold Creek	None	H8	27
2767	Gold Creek	None	H9	27
2768	Gold Creek	None	H10	27
2769	Gold Creek	None	H11	27
2770	Gold Creek	None	TD25	27
2771	Gold Creek	None	TD26	27
2772	Gold Creek	None	TD27	27
2773	Gold Creek	None	TD28	27
2774	Gold Creek	None	TD29	27
2775	Gold Creek	None	TD30	27
2776	Gold Creek	None	TD31	27
2777	Gold Creek	None	TD32	27
2778	Gold Creek	None	TD33	27
2779	Gold Creek	None	TD34	27
2780	Gold Creek	None	TD35A	27
2781	Gold Creek	None	TD35B	27
2782	Gold Creek	None	TD36	27
2783	Gold Creek	None	TD37	27
2784	Gold Creek	None	TD38	27
2785	Gold Creek	None	TD39	27
2786	Gold Creek	None	TD40	27
2787	Gold Creek	None	TD41	27
2788	Gold Creek	None	TD42	27
2789	Gold Creek	None	TD43	27
2790	Gold Creek	None	TD44	27
2791	Gold Creek	None	TD45	27
2792	Gold Creek	None	TD46	27
2793	Gold Creek	None	TD47	27
2794	Gold Creek	None	TD48	27
2795	Gold Creek	None	TD49	27
2796	Gold Creek	None	TD50	27
2797	Gold Creek	None	TD51	27
2798	Gold Creek	None	TD52	27
2799	Gold Creek	None	TD52A	27
2800	Gold Creek	None	TD53	27
2801	Gold Creek	None	TD54	27
2802	Gold Creek	None	TD55	27
2803	Gold Creek	None	TD56	27
2804	Gold Creek	None	TD57	27
2805	Gold Creek	None	TD58	27
2806	Gold Creek	None	TD59	27
2807	Gold Creek	None	TD60	27
2808	Gold Creek	None	TD61	27
2809	Gold Creek	None	TD1	27
2810	Gold Creek	None	TD2	27
2811	Gold Creek	None	TD3	27
2812	Gold Creek	None	TD4	27
2813	Gold Creek	None	TD5	27
2814	Gold Creek	None	TD5A	27
2815	Gold Creek	None	TD6	27
2816	Gold Creek	None	TD7	27
2817	Gold Creek	None	TD7A	27
2818	Gold Creek	None	TD8	27
2819	Gold Creek	None	TD9	27
2820	Gold Creek	None	TD10	27
2821	Gold Creek	None	TD11	27
2822	Gold Creek	None	TD12	27
2823	Gold Creek	None	TD13	27
2824	Gold Creek	None	TD14	27
2825	Gold Creek	None	TD15	27
2826	Gold Creek	None	TD15A	27
2827	Gold Creek	None	TD16	27
2828	Gold Creek	None	TD17	27
2829	Gold Creek	None	TD18	27
2830	Gold Creek	None	TD19	27
2831	North Beach	None	1	27
2832	North Beach	None	2	27
2833	North Beach	None	3	27
2834	North Beach	None	4	27
2835	North Beach	None	5	27
2836	North Beach	None	6	27
2837	North Beach	None	7	27
2838	North Beach	None	8	27
2839	North Beach	None	9	27
2840	North Beach	None	10	27
2841	North Beach	None	11	27
2842	North Beach	None	12	27
2843	North Beach	None	13	27
2844	North Beach	None	14	27
2845	North Beach	None	15	27
2846	North Beach	None	16	27
2847	North Beach	None	17	27
2848	North Beach	None	18	27
2849	North Beach	None	19	27
2850	North Beach	None	20	27
2851	North Beach	None	21	27
2852	North Beach	None	22	27
2853	North Beach	None	23	27
2854	North Beach	None	24	27
2855	North Beach	None	25	27
2856	North Beach	None	26	27
2857	North Beach	None	27	27
2858	North Beach	None	28	27
2859	North Beach	None	29	27
2860	North Beach	None	30	27
2861	North Beach	None	31	27
2862	North Beach	None	32	27
2863	North Beach	None	33	27
2864	North Beach	None	34	27
2865	North Beach	None	35	27
2866	North Beach	None	36	27
2867	North Beach	None	37	27
2868	North Beach	None	38	27
2869	North Beach	None	39	27
2870	North Beach	None	40	27
2871	North Beach	None	41	27
2872	North Beach	None	42	27
2873	North Beach	None	43	27
2874	North Beach	None	44	27
2875	North Beach	None	45	27
2876	North Beach	None	46	27
2877	North Beach	None	47	27
2878	North Beach	None	48	27
2879	North Beach	None	49	27
2880	North Beach	None	50	27
2881	North Beach	None	51	27
2882	North Beach	None	52	27
2883	North Beach	None	53	27
2884	North Beach	None	54	27
2885	North Beach	None	NB-H	27
2886	North Beach	None	G1-Golden Ears Group	27
2887	North Beach	None	G2-Alouette Group	27
2888	None	None	3	28
2889	None	None	5	28
2890	None	None	6A	28
2891	None	None	6B	28
2892	None	None	6C	28
2893	None	None	6D	28
2894	None	None	6E	28
2895	None	None	7A	28
2896	None	None	7B	28
2897	None	None	8	28
2898	None	None	9A	28
2899	None	None	9B	28
2900	None	None	10A	28
2901	None	None	10B	28
2902	None	None	11	28
2903	None	None	12A	28
2904	None	None	12B	28
2905	None	None	13A	28
2906	None	None	13B	28
2907	None	None	14	28
2908	None	None	15A	28
2909	None	None	15B	28
2910	None	None	16A	28
2911	None	None	16B	28
2912	None	None	17	28
2913	None	None	18A	28
2914	None	None	18B	28
2915	None	None	18C	28
2916	None	None	39A	28
2917	None	None	39B	28
2918	None	None	39C	28
2919	None	None	40	28
2920	None	None	40A	28
2921	None	None	44A	28
2922	None	None	44B	28
2923	None	None	45	28
2924	None	None	45B	28
2925	None	None	46	28
2926	None	None	47	28
2927	None	None	48	28
2928	None	None	49	28
2929	None	None	50	28
2930	None	None	51	28
2931	None	None	52	28
2932	None	None	53	28
2933	None	None	54	28
2934	None	None	55	28
2935	None	None	56	28
2936	None	None	57	28
2937	None	None	58	28
2938	None	None	59	28
2939	None	None	60	28
2940	None	None	61	28
2941	None	None	62	28
2942	None	None	63A	28
2943	None	None	63B	28
2944	None	None	64	28
2945	None	None	65	28
2946	None	None	66	28
2947	None	None	67	28
2948	None	None	68	28
2949	None	None	69	28
2950	None	None	70	28
2951	None	None	71	28
2952	None	None	72	28
2953	None	None	73	28
2954	None	None	74A	28
2955	None	None	74B	28
2956	None	None	75	28
2957	None	None	76	28
2958	None	None	77	28
2959	None	None	78	28
2960	None	None	79	28
2961	None	None	80	28
2962	None	None	81	28
2963	None	None	82	28
2964	None	None	83	28
2965	None	None	84	28
2966	None	None	85	28
2967	None	None	86	28
2968	None	None	87A	28
2969	None	None	87B	28
2970	None	None	88	28
2971	None	None	89	28
2972	None	None	90A	28
2973	None	None	90B	28
2974	None	None	91	28
2975	None	None	92A	28
2976	None	None	92B	28
2977	None	None	93	28
2978	None	None	94	28
2979	None	None	95	28
2980	None	None	96	28
2981	None	None	97	28
2982	None	None	98	28
2983	None	None	99	28
2984	None	None	100	28
2985	None	None	101	28
2986	None	None	102	28
2987	None	None	103	28
2988	None	None	104	28
2989	None	None	105	28
2990	None	None	106	28
2991	None	None	107	28
2992	None	None	108	28
2993	None	None	109A	28
2994	None	None	109B	28
2995	None	None	110	28
2996	None	None	111	28
2997	None	None	112	28
2998	None	None	113	28
2999	None	None	114A	28
3000	None	None	114B	28
3001	None	None	115	28
3002	None	None	116	28
3003	None	None	117	28
3004	None	None	118	28
3005	None	None	119	28
3006	None	None	120	28
3007	None	None	121	28
3008	None	None	122	28
3009	None	None	123	28
3010	None	None	124	28
3011	None	None	125	28
3012	None	None	126	28
3013	None	None	127	28
3014	None	None	128	28
3015	None	None	129	28
3016	None	None	130	28
3017	None	None	131	28
3018	None	None	132	28
3019	None	None	133	28
3020	None	None	134	28
3021	None	None	135	28
3022	None	None	136	28
3023	None	None	137	28
3024	None	None	138A	28
3025	None	None	138B	28
3026	None	None	139	28
3027	None	None	140	28
3028	None	None	141	28
3029	None	None	142	28
3030	None	None	143	28
3031	None	None	144	28
3032	Group Sites	None	G1-Goldminer (Lower Site) 	28
3033	Group Sites	None	G2-Prospector (Upper Site) 	28
3034	Campground	None	1	29
3035	Campground	None	2	29
3036	Campground	None	3	29
3037	Campground	None	4	29
3038	Campground	None	5	29
3039	Campground	None	6	29
3040	Campground	None	7	29
3041	Campground	None	8	29
3042	Campground	None	9	29
3043	Campground	None	10	29
3044	Campground	None	11	29
3045	Campground	None	12	29
3046	Campground	None	13	29
3047	Campground	None	14	29
3048	Campground	None	15	29
3049	Campground	None	16	29
3050	Campground	None	17	29
3051	Campground	None	18	29
3052	Campground	None	19	29
3053	Campground	None	20	29
3054	Campground	None	21	29
3055	Campground	None	22	29
3056	Campground	None	23	29
3057	Campground	None	24	29
3058	Campground	None	25	29
3059	Campground	None	26	29
3060	Campground	None	27	29
3061	Campground	None	28	29
3062	Campground	None	29	29
3063	Campground	None	30	29
3064	Campground	None	31	29
3065	Campground	None	32	29
3066	Campground	None	33	29
3067	Campground	None	34	29
3068	Campground	None	35	29
3069	Campground	None	36	29
3070	Campground	None	37	29
3071	Campground	None	38	29
3072	Campground	None	39	29
3073	Campground	None	40	29
3074	Campground	None	41	29
3075	Campground	None	42	29
3076	Campground	None	43	29
3077	Campground	None	44	29
3078	Campground	None	45	29
3079	Campground	None	46	29
3080	Campground	None	47	29
3081	Campground	None	48	29
3082	Campground	None	49	29
3083	Campground	None	50	29
3084	Campground	None	51	29
3085	Campground	None	52	29
3086	Campground	None	53	29
3087	Campground	None	54	29
3088	Campground	None	55	29
3089	Campground	None	56	29
3090	Campground	None	57	29
3091	Campground	None	58	29
3092	Campground	None	59	29
3093	Campground	None	60	29
3094	Campground	None	61	29
3095	Campground	None	62	29
3096	Campground	None	63	29
3097	Campground	None	64	29
3098	Campground	None	65	29
3099	Campground	None	66	29
3100	Campground	None	67	29
3101	Campground	None	68	29
3102	Campground	None	69	29
3103	Campground	None	70	29
3104	Campground	None	71	29
3105	Campground	None	72	29
3106	Campground	None	73	29
3107	Campground	None	74	29
3108	Campground	None	75	29
3109	Campground	None	76	29
3110	Campground	None	77	29
3111	Campground	None	78	29
3112	Campground	None	79	29
3113	Campground	None	80	29
3114	Campground	None	81	29
3115	Campground	None	82	29
3116	Campground	None	83	29
3117	Campground	None	84	29
3118	Campground	None	85	29
3119	Campground	None	86	29
3120	Campground	None	87	29
3121	Campground	None	88	29
3122	Campground	None	89	29
3123	Campground	None	90	29
3124	Campground	None	91	29
3125	Campground	None	92	29
3126	Campground	None	93	29
3127	Campground	None	94	29
3128	Campground	None	95	29
3129	Campground	None	96	29
3130	Campground	None	97	29
3131	Campground	None	98	29
3132	Campground	None	99	29
3133	Campground	None	100	29
3134	Campground	None	101	29
3135	Campground	None	102	29
3136	Campground	None	103	29
3137	Campground	None	104	29
3138	Campground	None	105	29
3139	Campground	None	106	29
3140	Campground	None	107	29
3141	Campground	None	108	29
3142	Campground	None	109	29
3143	Campground	None	110	29
3144	Campground	None	111	29
3145	Campground	None	112	29
3146	Campground	None	113	29
3147	Campground	None	114	29
3148	Campground	None	115	29
3149	Campground	None	116	29
3150	Campground	None	117	29
3151	Campground	None	118	29
3152	Campground	None	119	29
3153	Campground	None	120	29
3154	Campground	None	121	29
3155	Campground	None	122	29
3156	Campground	None	123	29
3157	Campground	None	124	29
3158	Campground	None	125	29
3159	Campground	None	126	29
3160	Group Site	None	G1-Swordfern	29
3161	Arrowhead	None	A1	30
3162	Arrowhead	None	A2	30
3163	Arrowhead	None	A3	30
3164	Arrowhead	None	A4	30
3165	Arrowhead	None	A5	30
3166	Arrowhead	None	A6	30
3167	Arrowhead	None	A7	30
3168	Arrowhead	None	A8	30
3169	Arrowhead	None	A9	30
3170	Arrowhead	None	A10	30
3171	Arrowhead	None	A11	30
3172	Arrowhead	None	A12	30
3173	Arrowhead	None	A13	30
3174	Arrowhead	None	A14	30
3175	Arrowhead	None	A15	30
3176	Arrowhead	None	A16	30
3177	Emerald Bay	None	E1	30
3178	Emerald Bay	None	E2	30
3179	Emerald Bay	None	E3	30
3180	Emerald Bay	None	E4	30
3181	Emerald Bay	None	E5	30
3182	Emerald Bay	None	E6	30
3183	Emerald Bay	None	E7	30
3184	Emerald Bay	None	E8	30
3185	Emerald Bay	None	E9	30
3186	Emerald Bay	None	E10	30
3187	Emerald Bay	None	E11	30
3188	Emerald Bay	None	E12	30
3189	Emerald Bay	None	E13	30
3190	Emerald Bay	None	E14	30
3191	Emerald Bay	None	E15	30
3192	Emerald Bay	None	E16	30
3193	Emerald Bay	None	E17	30
3194	Emerald Bay	None	E18	30
3195	Emerald Bay	None	E19	30
3196	Emerald Bay	None	E20	30
3197	Emerald Bay	None	E21	30
3198	Emerald Bay	None	E22	30
3199	Emerald Bay	None	E23	30
3200	Emerald Bay	None	E24	30
3201	Emerald Bay	None	E25	30
3202	Emerald Bay	None	E26	30
3203	Emerald Bay	None	E27	30
3204	Emerald Bay	None	E28	30
3205	Emerald Bay	None	E29	30
3206	Emerald Bay	None	E30	30
3207	Emerald Bay	None	E31	30
3208	Emerald Bay	None	E32	30
3209	Emerald Bay	None	E33	30
3210	Emerald Bay	None	E34	30
3211	Emerald Bay	None	E35	30
3212	Emerald Bay	None	E36	30
3213	Emerald Bay	None	E37	30
3214	Emerald Bay	None	E38	30
3215	Emerald Bay	None	E39	30
3216	Emerald Bay	None	E40	30
3217	Emerald Bay	None	E41	30
3218	Emerald Bay	None	E42	30
3219	Emerald Bay	None	E43	30
3220	Emerald Bay	None	E44	30
3221	Emerald Bay	None	E45	30
3222	Emerald Bay	None	E46	30
3223	Emerald Bay	None	E47	30
3224	Emerald Bay	None	E48	30
3225	Emerald Bay	None	E49	30
3226	Emerald Bay	None	E50	30
3227	Emerald Bay	None	E51	30
3228	Sunset View	None	S1	30
3229	Sunset View	None	S2	30
3230	Sunset View	None	S3	30
3231	Sunset View	None	S4	30
3232	Sunset View	None	S5	30
3233	Sunset View	None	S6	30
3234	Sunset View	None	S7	30
3235	Sunset View	None	S8	30
3236	Sunset View	None	S9	30
3237	Sunset View	None	S10	30
3238	Sunset View	None	S11	30
3239	Sunset View	None	S12	30
3240	Sunset View	None	S13	30
3241	Sunset View	None	S14	30
3242	Sunset View	None	S15	30
3243	Sunset View	None	S16	30
3244	Sunset View	None	S17	30
3245	Sunset View	None	S18	30
3246	Sunset View	None	S19	30
3247	Sunset View	None	S20	30
3248	Sunset View	None	S21	30
3249	Sunset View	None	S22	30
3250	Sunset View	None	S23	30
3251	Sunset View	None	S24	30
3252	Sunset View	None	S25	30
3253	Sunset View	None	S26	30
3254	Sunset View	None	S27	30
3255	Sunset View	None	S28	30
3256	Sunset View	None	S29	30
3257	Sunset View	None	S30	30
3258	Sunset View	None	S31	30
3259	Sunset View	None	S32	30
3260	Sunset View	None	S33	30
3261	Sunset View	None	S34	30
3262	Sunset View	None	S35	30
3263	Sunset View	None	S36	30
3264	Sunset View	None	S37	30
3265	Sunset View	None	S38	30
3266	Sunset View	None	S39	30
3267	Sunset View	None	S40	30
3268	Sunset View	None	S41	30
3269	Sunset View	None	S42	30
3270	Sunset View	None	S43	30
3271	Sunset View	None	S44	30
3272	Sunset View	None	S45	30
3273	Sunset View	None	S46	30
3274	Sunset View	None	S47	30
3275	Sunset View	None	S48	30
3276	Sunset View	None	S49	30
3277	Sunset View	None	S50	30
3278	Sunset View	None	S51	30
3279	Sunset View	None	S52	30
3280	Sunset View	None	S53	30
3281	Sunset View	None	S54	30
3282	Sunset View	None	S55	30
3283	Sunset View	None	S56	30
3284	Sunset View	None	SV Groupsite	30
3285	Campgrounds	None	A1	31
3286	Campgrounds	None	A2	31
3287	Campgrounds	None	A3	31
3288	Campgrounds	None	A4	31
3289	Campgrounds	None	A5	31
3290	Campgrounds	None	A6	31
3291	Campgrounds	None	A7	31
3292	Campgrounds	None	A8	31
3293	Campgrounds	None	A9	31
3294	Campgrounds	None	A10	31
3295	Campgrounds	None	A11	31
3296	Campgrounds	None	A12	31
3297	Campgrounds	None	A13	31
3298	Campgrounds	None	A14	31
3299	Campgrounds	None	A15	31
3300	Campgrounds	None	A16	31
3301	Campgrounds	None	A17	31
3302	Campgrounds	None	A18	31
3303	Campgrounds	None	A19	31
3304	Campgrounds	None	A20	31
3305	Campgrounds	None	A21	31
3306	Campgrounds	None	A22	31
3307	Campgrounds	None	A23	31
3308	Campgrounds	None	A24	31
3309	Campgrounds	None	A25	31
3310	Campgrounds	None	A26	31
3311	Campgrounds	None	A27	31
3312	Campgrounds	None	A28	31
3313	Campgrounds	None	A29	31
3314	Campgrounds	None	A30	31
3315	Campgrounds	None	A31	31
3316	Campgrounds	None	A32	31
3317	Campgrounds	None	A33	31
3318	Campgrounds	None	A34	31
3319	Campgrounds	None	A35	31
3320	Campgrounds	None	A36	31
3321	Campgrounds	None	A37	31
3322	Campgrounds	None	A38	31
3323	Campgrounds	None	A39	31
3324	Campgrounds	None	A40	31
3325	Campgrounds	None	A41	31
3326	Campgrounds	None	A42	31
3327	Campgrounds	None	A43	31
3328	Campgrounds	None	A44	31
3329	Campgrounds	None	A45	31
3330	Campgrounds	None	A46	31
3331	Campgrounds	None	A47	31
3332	Campgrounds	None	A48	31
3333	Campgrounds	None	A49	31
3334	Campgrounds	None	A50	31
3335	Campgrounds	None	A51	31
3336	Campgrounds	None	H1	31
3337	Campgrounds	None	H2	31
3338	Campgrounds	None	H3	31
3339	Campgrounds	None	H4	31
3340	Campgrounds	None	H5	31
3341	Campgrounds	None	H6	31
3342	Campgrounds	None	H7	31
3343	Campgrounds	None	H8	31
3344	Campgrounds	None	H52	31
3345	Campgrounds	None	H53	31
3346	Campgrounds	None	H54	31
3347	Campgrounds	None	H55	31
3348	Campgrounds	None	H56	31
3349	Campgrounds	None	H57	31
3350	Campgrounds	None	H58	31
3351	Campgrounds	None	H59	31
3352	Campgrounds	None	H60	31
3353	Campgrounds	None	H61	31
3354	Campgrounds	None	H62	31
3355	Campgrounds	None	H63	31
3356	Campgrounds	None	H64	31
3357	Campgrounds	None	H65	31
3358	Campgrounds	None	H66	31
3359	Campgrounds	None	H67	31
3360	Campgrounds	None	H68	31
3361	Campgrounds	None	H69	31
3362	Campgrounds	None	H70	31
3363	Campgrounds	None	H71	31
3364	Campgrounds	None	72A	31
3365	Campgrounds	None	72A	31
3366	Campgrounds	None	H73	31
3367	Campgrounds	None	H74	31
3368	Campgrounds	None	H75	31
3369	Campgrounds	None	H76	31
3370	Campgrounds	None	H77	31
3371	Campgrounds	None	H78	31
3372	Campgrounds	None	H79	31
3373	Campgrounds	None	H80	31
3374	Campgrounds	None	H81	31
3375	Campgrounds	None	H82	31
3376	Campgrounds	None	H83	31
3377	Campgrounds	None	H84	31
3378	Campgrounds	None	H85	31
3379	Campgrounds	None	H86	31
3380	Campgrounds	None	H87	31
3381	Campgrounds	None	H88	31
3382	Campgrounds	None	H89	31
3383	Campgrounds	None	H90	31
3384	Campgrounds	None	H91	31
3385	Campgrounds	None	H92	31
3386	Campgrounds	None	H93	31
3387	Campgrounds	None	H94	31
3388	Campgrounds	None	H95	31
3389	Campgrounds	None	H96	31
3390	Campgrounds	None	H97	31
3391	Campgrounds	None	H98	31
3392	Campgrounds	None	H99	31
3393	Campgrounds	None	H100	31
3394	Campgrounds	None	H101	31
3395	Campgrounds	None	H102	31
3396	Campgrounds	None	H103	31
3397	Campgrounds	None	H104	31
3398	Campgrounds	None	H105	31
3399	Campgrounds	None	H106	31
3400	Campgrounds	None	H107	31
3401	Campgrounds	None	H108	31
3402	Campgrounds	None	H109	31
3403	Campgrounds	None	H110	31
3404	Campgrounds	None	H111	31
3405	Campgrounds	None	H112	31
3406	Campgrounds	None	H113	31
3407	Campgrounds	None	H114	31
3408	Campgrounds	None	H115	31
3409	Campgrounds	None	H116	31
3410	Campgrounds	None	H117	31
3411	Campgrounds	None	H118	31
3412	Campgrounds	None	H119	31
3413	Campgrounds	None	SV Groupsite	31
3414	None	None	1	32
3415	None	None	2	32
3416	None	None	3	32
3417	None	None	4	32
3418	None	None	5	32
3419	None	None	6	32
3420	None	None	7	32
3421	None	None	8	32
3422	None	None	9	32
3423	None	None	10	32
3424	None	None	11	32
3425	None	None	12	32
3426	None	None	13	32
3427	None	None	14	32
3428	None	None	15	32
3429	None	None	16	32
3430	None	None	17	32
3431	None	None	18	32
3432	None	None	19	32
3433	None	None	20	32
3434	None	None	21	32
3435	None	None	22	32
3436	None	None	23	32
3437	Campground	None	1	33
3438	Campground	None	2	33
3439	Campground	None	3	33
3440	Campground	None	4	33
3441	Campground	None	5	33
3442	Campground	None	6	33
3443	Campground	None	7	33
3444	Campground	None	8	33
3445	Campground	None	9	33
3446	Campground	None	10	33
3447	Campground	None	11	33
3448	Campground	None	12	33
3449	Campground	None	13	33
3450	Campground	None	14	33
3451	Campground	None	15	33
3452	Campground	None	16	33
3453	Campground	None	17	33
3454	Campground	None	18	33
3455	Campground	None	19	33
3456	Campground	None	20	33
3457	Campground	None	21	33
3458	Campground	None	22	33
3459	Campground	None	23	33
3460	China Beach Campground	None	1	34
3461	China Beach Campground	None	2	34
3462	China Beach Campground	None	3	34
3463	China Beach Campground	None	4	34
3464	China Beach Campground	None	5	34
3465	China Beach Campground	None	6	34
3466	China Beach Campground	None	7	34
3467	China Beach Campground	None	8	34
3468	China Beach Campground	None	9	34
3469	China Beach Campground	None	10	34
3470	China Beach Campground	None	11	34
3471	China Beach Campground	None	12	34
3472	China Beach Campground	None	13	34
3473	China Beach Campground	None	14	34
3474	China Beach Campground	None	15	34
3475	China Beach Campground	None	16	34
3476	China Beach Campground	None	17	34
3477	China Beach Campground	None	18	34
3478	China Beach Campground	None	19	34
3479	China Beach Campground	None	20	34
3480	China Beach Campground	None	21	34
3481	China Beach Campground	None	22	34
3482	China Beach Campground	None	23	34
3483	China Beach Campground	None	24	34
3484	China Beach Campground	None	25	34
3485	China Beach Campground	None	26	34
3486	China Beach Campground	None	27	34
3487	China Beach Campground	None	28	34
3488	China Beach Campground	None	29	34
3489	China Beach Campground	None	30	34
3490	China Beach Campground	None	31	34
3491	China Beach Campground	None	32	34
3492	China Beach Campground	None	33	34
3493	China Beach Campground	None	34	34
3494	China Beach Campground	None	35	34
3495	China Beach Campground	None	36	34
3496	China Beach Campground	None	37	34
3497	China Beach Campground	None	38	34
3498	China Beach Campground	None	39	34
3499	China Beach Campground	None	40	34
3500	China Beach Campground	None	41	34
3501	China Beach Campground	None	42	34
3502	China Beach Campground	None	43	34
3503	China Beach Campground	None	44	34
3504	China Beach Campground	None	45	34
3505	China Beach Campground	None	46	34
3506	China Beach Campground	None	47	34
3507	China Beach Campground	None	48	34
3508	China Beach Campground	None	49	34
3509	China Beach Campground	None	50	34
3510	China Beach Campground	None	51	34
3511	China Beach Campground	None	52	34
3512	China Beach Campground	None	53	34
3513	China Beach Campground	None	54	34
3514	China Beach Campground	None	55	34
3515	China Beach Campground	None	56	34
3516	China Beach Campground	None	57	34
3517	China Beach Campground	None	58	34
3518	China Beach Campground	None	59	34
3519	China Beach Campground	None	60	34
3520	China Beach Campground	None	61	34
3521	China Beach Campground	None	62	34
3522	China Beach Campground	None	63	34
3523	China Beach Campground	None	64	34
3524	China Beach Campground	None	65	34
3525	China Beach Campground	None	66	34
3526	China Beach Campground	None	67	34
3527	China Beach Campground	None	68	34
3528	China Beach Campground	None	69	34
3529	China Beach Campground	None	70	34
3530	China Beach Campground	None	71	34
3531	China Beach Campground	None	72	34
3532	China Beach Campground	None	73	34
3533	China Beach Campground	None	74	34
3534	China Beach Campground	None	75	34
3535	China Beach Campground	None	76	34
3536	China Beach Campground	None	77	34
3537	China Beach Campground	None	78	34
3538	China Beach Campground	None	79	34
3539	China Beach Campground	None	80	34
3540	China Beach Campground	None	81	34
3541	China Beach Campground	None	82	34
3542	China Beach Campground	None	83	34
3543	China Beach Campground	None	84	34
3544	China Beach Campground	None	85	34
3545	Sites 1-16, 22-32	None	1	35
3546	Sites 1-16, 22-32	None	2	35
3547	Sites 1-16, 22-32	None	3	35
3548	Sites 1-16, 22-32	None	4	35
3549	Sites 1-16, 22-32	None	5	35
3550	Sites 1-16, 22-32	None	6	35
3551	Sites 1-16, 22-32	None	7	35
3552	Sites 1-16, 22-32	None	8	35
3553	Sites 1-16, 22-32	None	9	35
3554	Sites 1-16, 22-32	None	10	35
3555	Sites 1-16, 22-32	None	11	35
3556	Sites 1-16, 22-32	None	12	35
3557	Sites 1-16, 22-32	None	13	35
3558	Sites 1-16, 22-32	None	14	35
3559	Sites 1-16, 22-32	None	15	35
3560	Sites 1-16, 22-32	None	16	35
3561	Sites 1-16, 22-32	None	22	35
3562	Sites 1-16, 22-32	None	23	35
3563	Sites 1-16, 22-32	None	24	35
3564	Sites 1-16, 22-32	None	25	35
3565	Sites 1-16, 22-32	None	26	35
3566	Sites 1-16, 22-32	None	27	35
3567	Sites 1-16, 22-32	None	28	35
3568	Sites 1-16, 22-32	None	29	35
3569	Sites 1-16, 22-32	None	30	35
3570	Sites 1-16, 22-32	None	31	35
3571	Sites 1-16, 22-32	None	32	35
3572	Sites 17-21	None	17	35
3573	Sites 17-21	None	18	35
3574	Sites 17-21	None	19	35
3575	Sites 17-21	None	20	35
3576	Sites 17-21	None	21	35
3577	None	None	1	36
3578	None	None	2	36
3579	None	None	3	36
3580	None	None	4	36
3581	None	None	5	36
3582	None	None	6	36
3583	None	None	7	36
3584	None	None	8	36
3585	None	None	9	36
3586	None	None	10	36
3587	None	None	11	36
3588	None	None	12	36
3589	None	None	13	36
3590	None	None	14	36
3591	None	None	15	36
3592	None	None	16	36
3593	None	None	17	36
3594	None	None	18	36
3595	None	None	19	36
3596	None	None	20	36
3597	None	None	21	36
3598	None	None	22	36
3599	None	None	23	36
3600	None	None	24	36
3601	None	None	25	36
3602	None	None	26	36
3603	None	None	27	36
3604	None	None	28	36
3605	None	None	29	36
3606	None	None	30	36
3607	None	None	31	36
3608	None	None	32	36
3609	None	None	33	36
3610	None	None	34	36
3611	None	None	35	36
3612	None	None	36	36
3613	None	None	37	36
3614	None	None	38	36
3615	None	None	39	36
3616	None	None	40	36
3617	None	None	41	36
3618	None	None	42	36
3619	None	None	43	36
3620	None	None	44	36
3621	None	None	45	36
3622	None	None	46	36
3623	None	None	47	36
3624	None	None	48	36
3625	None	None	49	36
3626	None	None	50	36
3627	None	None	51	36
3628	None	None	52	36
3629	None	None	53	36
3630	None	None	54	36
3631	None	None	55	36
3632	None	None	56	36
3633	None	None	57	36
3634	None	None	58	36
3635	None	None	59	36
3636	None	None	60	36
3637	None	None	61	36
3638	None	None	62	36
3639	None	None	63	36
3640	None	None	64	36
3641	None	None	65	36
3642	None	None	66	36
3643	None	None	67	36
3644	None	None	68	36
3645	None	None	69	36
3646	None	None	70	36
3647	None	None	71	36
3648	None	None	72	36
3649	None	None	73	36
3650	None	None	TD1	36
3651	None	None	TD2	36
3652	None	None	TD3	36
3653	None	None	TD4	36
3654	Sites 1-35	None	1	37
3655	Sites 1-35	None	2	37
3656	Sites 1-35	None	3	37
3657	Sites 1-35	None	4	37
3658	Sites 1-35	None	5	37
3659	Sites 1-35	None	6	37
3660	Sites 1-35	None	7	37
3661	Sites 1-35	None	8	37
3662	Sites 1-35	None	9	37
3663	Sites 1-35	None	10	37
3664	Sites 1-35	None	11	37
3665	Sites 1-35	None	12	37
3666	Sites 1-35	None	13	37
3667	Sites 1-35	None	14	37
3668	Sites 1-35	None	15	37
3669	Sites 1-35	None	16	37
3670	Sites 1-35	None	17	37
3671	Sites 1-35	None	18	37
3672	Sites 1-35	None	19	37
3673	Sites 1-35	None	20	37
3674	Sites 1-35	None	21	37
3675	Sites 1-35	None	22	37
3676	Sites 1-35	None	23	37
3677	Sites 1-35	None	24	37
3678	Sites 1-35	None	25	37
3679	Sites 1-35	None	26	37
3680	Sites 1-35	None	27	37
3681	Sites 1-35	None	28	37
3682	Sites 1-35	None	29	37
3683	Sites 1-35	None	30	37
3684	Sites 1-35	None	31	37
3685	Sites 1-35	None	32	37
3686	Sites 1-35	None	33	37
3687	Sites 1-35	None	34	37
3688	Sites 1-35	None	35	37
3689	Alleyne Lake and West Pond	None	36	37
3690	Alleyne Lake and West Pond	None	37	37
3691	Alleyne Lake and West Pond	None	38	37
3692	Alleyne Lake and West Pond	None	39	37
3693	Alleyne Lake and West Pond	None	40	37
3694	Alleyne Lake and West Pond	None	41	37
3695	Alleyne Lake and West Pond	None	43	37
3696	Alleyne Lake and West Pond	None	44	37
3697	Alleyne Lake and West Pond	None	45	37
3698	Alleyne Lake and West Pond	None	46	37
3699	Alleyne Lake and West Pond	None	56	37
3700	Alleyne Lake and West Pond	None	57	37
3701	Alleyne Lake and West Pond	None	58	37
3702	Alleyne Lake and West Pond	None	G1	37
3703	Sites 1-87	None	1	38
3704	Sites 1-87	None	2	38
3705	Sites 1-87	None	3	38
3706	Sites 1-87	None	4	38
3707	Sites 1-87	None	5	38
3708	Sites 1-87	None	6	38
3709	Sites 1-87	None	7	38
3710	Sites 1-87	None	8	38
3711	Sites 1-87	None	9	38
3712	Sites 1-87	None	10	38
3713	Sites 1-87	None	11	38
3714	Sites 1-87	None	12	38
3715	Sites 1-87	None	13	38
3716	Sites 1-87	None	14	38
3717	Sites 1-87	None	15	38
3718	Sites 1-87	None	16	38
3719	Sites 1-87	None	17	38
3720	Sites 1-87	None	18	38
3721	Sites 1-87	None	19	38
3722	Sites 1-87	None	20	38
3723	Sites 1-87	None	21	38
3724	Sites 1-87	None	22	38
3725	Sites 1-87	None	23	38
3726	Sites 1-87	None	24	38
3727	Sites 1-87	None	25	38
3728	Sites 1-87	None	26	38
3729	Sites 1-87	None	27	38
3730	Sites 1-87	None	28	38
3731	Sites 1-87	None	29	38
3732	Sites 1-87	None	30	38
3733	Sites 1-87	None	31	38
3734	Sites 1-87	None	32	38
3735	Sites 1-87	None	33	38
3736	Sites 1-87	None	34	38
3737	Sites 1-87	None	35	38
3738	Sites 1-87	None	36	38
3739	Sites 1-87	None	37	38
3740	Sites 1-87	None	38	38
3741	Sites 1-87	None	39	38
3742	Sites 1-87	None	40	38
3743	Sites 1-87	None	41	38
3744	Sites 1-87	None	42	38
3745	Sites 1-87	None	43	38
3746	Sites 1-87	None	44	38
3747	Sites 1-87	None	45	38
3748	Sites 1-87	None	46	38
3749	Sites 1-87	None	47	38
3750	Sites 1-87	None	48	38
3751	Sites 1-87	None	49	38
3752	Sites 1-87	None	50	38
3753	Sites 1-87	None	51	38
3754	Sites 1-87	None	52	38
3755	Sites 1-87	None	53	38
3756	Sites 1-87	None	54A	38
3757	Sites 1-87	None	54	38
3758	Sites 1-87	None	55	38
3759	Sites 1-87	None	56	38
3760	Sites 1-87	None	57	38
3761	Sites 1-87	None	58	38
3762	Sites 1-87	None	59	38
3763	Sites 1-87	None	60	38
3764	Sites 1-87	None	61	38
3765	Sites 1-87	None	62	38
3766	Sites 1-87	None	63	38
3767	Sites 1-87	None	64	38
3768	Sites 1-87	None	65	38
3769	Sites 1-87	None	66	38
3770	Sites 1-87	None	67	38
3771	Sites 1-87	None	68	38
3772	Sites 1-87	None	69	38
3773	Sites 1-87	None	70	38
3774	Sites 1-87	None	71	38
3775	Sites 1-87	None	72	38
3776	Sites 1-87	None	73	38
3777	Sites 1-87	None	74	38
3778	Sites 1-87	None	75	38
3779	Sites 1-87	None	76	38
3780	Sites 1-87	None	77	38
3781	Sites 1-87	None	78	38
3782	Sites 1-87	None	79	38
3783	Sites 1-87	None	80	38
3784	Sites 1-87	None	81	38
3785	Sites 1-87	None	82	38
3786	Sites 1-87	None	83	38
3787	Sites 1-87	None	84	38
3788	Sites 1-87	None	85	38
3789	Sites 1-87	None	86	38
3790	Sites 1-87	None	87	38
3791	Sites 88-114	None	88	38
3792	Sites 88-114	None	89	38
3793	Sites 88-114	None	90	38
3794	Sites 88-114	None	91	38
3795	Sites 88-114	None	92	38
3796	Sites 88-114	None	93	38
3797	Sites 88-114	None	94	38
3798	Sites 88-114	None	95	38
3799	Sites 88-114	None	96	38
3800	Sites 88-114	None	97	38
3801	Sites 88-114	None	98	38
3802	Sites 88-114	None	99	38
3803	Sites 88-114	None	100	38
3804	Sites 88-114	None	101	38
3805	Sites 88-114	None	102	38
3806	Sites 88-114	None	103	38
3807	Sites 88-114	None	104	38
3808	Sites 88-114	None	105	38
3809	Sites 88-114	None	106	38
3810	Sites 88-114	None	107	38
3811	Sites 88-114	None	108	38
3812	Sites 88-114	None	109	38
3813	Sites 88-114	None	110	38
3814	Sites 88-114	None	111	38
3815	Sites 88-114	None	112	38
3816	Sites 88-114	None	113	38
3817	Sites 88-114	None	114	38
3818	Group Sites	None	G1	38
3819	Group Sites	None	G2	38
3820	Kalispell	None	K1	39
3821	Kalispell	None	K2	39
3822	Kalispell	None	K3	39
3823	Kalispell	None	K4	39
3824	Kalispell	None	K5	39
3825	Kalispell	None	K6	39
3826	Kalispell	None	K7	39
3827	Kalispell	None	K8	39
3828	Kalispell	None	K9	39
3829	Kalispell	None	K10	39
3830	Kalispell	None	K11	39
3831	Kalispell	None	K12	39
3832	Kalispell	None	K13	39
3833	Kalispell	None	K14	39
3834	Kalispell	None	K15	39
3835	Kalispell	None	K16	39
3836	Kalispell	None	K17	39
3837	Kalispell	None	K18	39
3838	Kalispell	None	K19	39
3839	Kalispell	None	K20	39
3840	Kalispell	None	K21	39
3841	Kalispell	None	K22	39
3842	Kalispell	None	K23	39
3843	Kalispell	None	K24	39
3844	Kalispell	None	K25	39
3845	Kalispell	None	K26	39
3846	Kalispell	None	K27	39
3847	Kalispell	None	K28	39
3848	Kalispell	None	K29	39
3849	Kalispell	None	K30	39
3850	Surveyors	None	S1	39
3851	Surveyors	None	S2	39
3852	Surveyors	None	S3	39
3853	Surveyors	None	S4	39
3854	Surveyors	None	S5	39
3855	Surveyors	None	S6	39
3856	Surveyors	None	S7	39
3857	Surveyors	None	S8	39
3858	Surveyors	None	S9	39
3859	Surveyors	None	S10	39
3860	Surveyors	None	S11	39
3861	Surveyors	None	S12	39
3862	Surveyors	None	S13	39
3863	Surveyors	None	S14	39
3864	Surveyors	None	S15	39
3865	Surveyors	None	S16	39
3866	Surveyors	None	S17	39
3867	Surveyors	None	S18A	39
3868	Surveyors	None	S18B	39
3869	Surveyors	None	S19	39
3870	Surveyors	None	S20	39
3871	Surveyors	None	S21	39
3872	Surveyors	None	S22	39
3873	Surveyors	None	S23	39
3874	Surveyors	None	S24	39
3875	Surveyors	None	S25	39
3876	Surveyors	None	S26	39
3877	Surveyors	None	S27	39
3878	Surveyors	None	S28	39
3879	Surveyors	None	S29	39
3880	Surveyors	None	S30	39
3881	Surveyors	None	S31	39
3882	Surveyors	None	S32	39
3883	Surveyors	None	S33	39
3884	Surveyors	None	S34	39
3885	Surveyors	None	S35	39
3886	Surveyors	None	S36	39
3887	Surveyors	None	S37	39
3888	Surveyors	None	S38	39
3889	Surveyors	None	S39	39
3890	Surveyors	None	S40	39
3891	Surveyors	None	S41	39
3892	Surveyors	None	S42	39
3893	Surveyors	None	S43	39
3894	Surveyors	None	S44	39
3895	Surveyors	None	S45	39
3896	Surveyors	None	S46	39
3897	Surveyors	None	S47	39
3898	Surveyors	None	S48	39
3899	Surveyors	None	S49	39
3900	Surveyors	None	S50	39
3901	Surveyors	None	S51	39
3902	Surveyors	None	S52	39
3903	Surveyors	None	S53	39
3904	Surveyors	None	S54	39
3905	Surveyors	None	S55	39
3906	Surveyors	None	S56	39
3907	Surveyors	None	S57	39
3908	Surveyors	None	S58	39
3909	Surveyors	None	S59	39
3910	Surveyors	None	S60	39
3911	Surveyors	None	S61	39
3912	Surveyors	None	S62	39
3913	Surveyors	None	S63	39
3914	Surveyors	None	S64	39
3915	Surveyors	None	S65	39
3916	Surveyors	None	S66	39
3917	Surveyors	None	S67	39
3918	Surveyors	None	S68	39
3919	Surveyors	None	S69	39
3920	Surveyors	None	S70	39
3921	Surveyors	None	S71	39
3922	Surveyors	None	S72	39
3923	Surveyors	None	S73	39
3924	Surveyors	None	S74	39
3925	Surveyors	None	S75	39
3926	Surveyors	None	S76	39
3927	Surveyors	None	S77	39
3928	Surveyors	None	S78	39
3929	Surveyors	None	S79	39
3930	Surveyors	None	S80	39
3931	Surveyors	None	S81	39
3932	Surveyors	None	S82	39
3933	Surveyors	None	S83	39
3934	Surveyors	None	S84	39
3935	Surveyors	None	S85	39
3936	Surveyors	None	S86	39
3937	Surveyors	None	S87	39
3938	Surveyors	None	S88	39
3939	Surveyors	None	S89	39
3940	Surveyors	None	S90	39
3941	Surveyors	None	S91	39
3942	Surveyors	None	S92	39
3943	Surveyors	None	S93	39
3944	Surveyors	None	S94	39
3945	Surveyors	None	S95	39
3946	Surveyors	None	S96	39
3947	Surveyors	None	S97	39
3948	Surveyors	None	S98	39
3949	Surveyors	None	S99	39
3950	Surveyors	None	S100	39
3951	Surveyors	None	S101	39
3952	Surveyors	None	S102	39
3953	Surveyors	None	S103	39
3954	Surveyors	None	S104	39
3955	Ponderosa	None	P1	39
3956	Ponderosa	None	P2	39
3957	Ponderosa	None	P3	39
3958	Ponderosa	None	P4	39
3959	Ponderosa	None	P5	39
3960	Ponderosa	None	P6	39
3961	Ponderosa	None	P7	39
3962	Ponderosa	None	P8	39
3963	Ponderosa	None	P9	39
3964	Ponderosa	None	P10	39
3965	Ponderosa	None	P11	39
3966	Ponderosa	None	P12	39
3967	Ponderosa	None	P13	39
3968	Ponderosa	None	P14	39
3969	Ponderosa	None	P15	39
3970	Ponderosa	None	P16	39
3971	Ponderosa	None	P17	39
3972	Ponderosa	None	P18	39
3973	Ponderosa	None	P19	39
3974	Ponderosa	None	P20	39
3975	Ponderosa	None	P21	39
3976	Ponderosa	None	P22	39
3977	Ponderosa	None	P23	39
3978	Ponderosa	None	P24	39
3979	Ponderosa	None	P25	39
3980	Ponderosa	None	P26	39
3981	Ponderosa	None	P27	39
3982	Ponderosa	None	P28	39
3983	Ponderosa	None	P29	39
3984	Ponderosa	None	P30	39
3985	Ponderosa	None	P31	39
3986	Ponderosa	None	P32	39
3987	Ponderosa	None	P33	39
3988	Ponderosa	None	P34	39
3989	Ponderosa	None	P35	39
3990	Ponderosa	None	P36	39
3991	Ponderosa	None	P37	39
3992	Group Sites	None	G1-South Pool Group	39
3993	Group Sites	None	G2-Ponderosa Group	39
3994	None	None	1	40
3995	None	None	2	40
3996	None	None	3	40
3997	None	None	4	40
3998	None	None	5	40
3999	None	None	6	40
4000	None	None	7	40
4001	None	None	8	40
4002	None	None	9	40
4003	None	None	10	40
4004	None	None	11	40
4005	None	None	12	40
4006	None	None	13	40
4007	None	None	14	40
4008	None	None	15	40
4009	None	None	16	40
4010	None	None	17	40
4011	None	None	18	40
4012	None	None	19	40
4013	None	None	20	40
4014	None	None	21	40
4015	None	None	22	40
4016	None	None	23	40
4017	None	None	24	40
4018	None	None	25	40
4019	None	None	26	40
4020	None	None	27	40
4021	None	None	28	40
4022	None	None	29	40
4023	None	None	30	40
4024	None	None	31	40
4025	None	None	32	40
4026	None	None	33	40
4027	None	None	34	40
4028	Redfish Campground	None	114	41
4029	Redfish Campground	None	115	41
4030	Redfish Campground	None	116	41
4031	Redfish Campground	None	117	41
4032	Redfish Campground	None	118	41
4033	Redfish Campground	None	119	41
4034	Redfish Campground	None	120	41
4035	Redfish Campground	None	121	41
4036	Redfish Campground	None	122	41
4037	Redfish Campground	None	123	41
4038	Redfish Campground	None	124	41
4039	Redfish Campground	None	125	41
4040	Redfish Campground	None	126	41
4041	Redfish Campground	None	127	41
4042	Redfish Campground	None	128	41
4043	Redfish Campground	None	129	41
4044	Redfish Campground	None	130	41
4045	Redfish Campground	None	131	41
4046	Redfish Campground	None	132	41
4047	Sandspit Campground	None	1	41
4048	Sandspit Campground	None	2	41
4049	Sandspit Campground	None	3	41
4050	Sandspit Campground	None	4	41
4051	Sandspit Campground	None	5	41
4052	Sandspit Campground	None	6	41
4053	Sandspit Campground	None	7	41
4054	Sandspit Campground	None	8	41
4055	Sandspit Campground	None	9	41
4056	Sandspit Campground	None	10	41
4057	Sandspit Campground	None	11	41
4058	Sandspit Campground	None	12	41
4059	Sandspit Campground	None	13	41
4060	Sandspit Campground	None	14	41
4061	Sandspit Campground	None	15	41
4062	Sandspit Campground	None	16	41
4063	Sandspit Campground	None	17	41
4064	Sandspit Campground	None	18	41
4065	Sandspit Campground	None	19	41
4066	Sandspit Campground	None	20	41
4067	Sandspit Campground	None	21	41
4068	Sandspit Campground	None	22	41
4069	Sandspit Campground	None	23	41
4070	Sandspit Campground	None	24	41
4071	Sandspit Campground	None	25	41
4072	Sandspit Campground	None	26	41
4073	Sandspit Campground	None	27	41
4074	Sandspit Campground	None	28	41
4075	Sandspit Campground	None	29	41
4076	Sandspit Campground	None	30	41
4077	Sandspit Campground	None	31	41
4078	Sandspit Campground	None	32	41
4079	Sandspit Campground	None	33	41
4080	Sandspit Campground	None	34	41
4081	Sandspit Campground	None	35	41
4082	Sandspit Campground	None	36	41
4083	Sandspit Campground	None	37	41
4084	Sandspit Campground	None	38	41
4085	Sandspit Campground	None	39	41
4086	Sandspit Campground	None	40	41
4087	Sandspit Campground	None	41	41
4088	Sandspit Campground	None	42	41
4089	Sandspit Campground	None	43	41
4090	Sandspit Campground	None	44	41
4091	Sandspit Campground	None	45	41
4092	Sandspit Campground	None	46	41
4093	Sandspit Campground	None	47	41
4094	Sandspit Campground	None	48	41
4095	Sandspit Campground	None	49	41
4096	Sandspit Campground	None	50	41
4097	Sandspit Campground	None	51	41
4098	Sandspit Campground	None	52	41
4099	Sandspit Campground	None	53	41
4100	Sandspit Campground	None	54	41
4101	Sandspit Campground	None	55	41
4102	Sandspit Campground	None	56	41
4103	Sandspit Campground	None	57	41
4104	Sandspit Campground	None	58	41
4105	Sandspit Campground	None	59	41
4106	Sandspit Campground	None	60	41
4107	Sandspit Campground	None	61	41
4108	Sandspit Campground	None	62	41
4109	Sandspit Campground	None	63	41
4110	Sandspit Campground	None	64	41
4111	Sandspit Campground	None	65	41
4112	Sandspit Campground	None	66	41
4113	Sandspit Campground	None	67	41
4114	Sandspit Campground	None	68	41
4115	Sandspit Campground	None	69	41
4116	Sandspit Campground	None	70	41
4117	Sandspit Campground	None	71	41
4118	Sandspit Campground	None	72	41
4119	Sandspit Campground	None	73	41
4120	Sandspit Campground	None	74	41
4121	Sandspit Campground	None	75	41
4122	Sandspit Campground	None	76	41
4123	Sandspit Campground	None	77	41
4124	Sandspit Campground	None	78	41
4125	Sandspit Campground	None	79	41
4126	Sandspit Campground	None	80	41
4127	Sandspit Campground	None	81	41
4128	Sandspit Campground	None	82	41
4129	Sandspit Campground	None	83	41
4130	Sandspit Campground	None	84	41
4131	Sandspit Campground	None	85	41
4132	Sandspit Campground	None	86	41
4133	Sandspit Campground	None	87	41
4134	Sandspit Campground	None	88	41
4135	Sandspit Campground	None	89	41
4136	Sandspit Campground	None	90	41
4137	Sandspit Campground	None	91	41
4138	Sandspit Campground	None	92	41
4139	Sandspit Campground	None	93	41
4140	Sandspit Campground	None	94	41
4141	Sandspit Campground	None	95	41
4142	Sandspit Campground	None	96	41
4143	Sandspit Campground	None	97	41
4144	Sandspit Campground	None	98	41
4145	Sandspit Campground	None	99	41
4146	Sandspit Campground	None	100	41
4147	Sandspit Campground	None	101	41
4148	Sandspit Campground	None	102	41
4149	Sandspit Campground	None	103	41
4150	Sandspit Campground	None	104	41
4151	Sandspit Campground	None	105	41
4152	Sandspit Campground	None	106	41
4153	Sandspit Campground	None	107	41
4154	Sandspit Campground	None	108	41
4155	Sandspit Campground	None	109	41
4156	Sandspit Campground	None	110	41
4157	Sandspit Campground	None	111	41
4158	Sandspit Campground	None	112	41
4159	Sandspit Campground	None	113	41
4160	Friends Campground	None	133	41
4161	Friends Campground	None	134	41
4162	Friends Campground	None	135	41
4163	Friends Campground	None	136	41
4164	Friends Campground	None	137	41
4165	Friends Campground	None	138	41
4166	Friends Campground	None	139	41
4167	Friends Campground	None	140	41
4168	Friends Campground	None	141	41
4169	Friends Campground	None	142	41
4170	Friends Campground	None	143	41
4171	Friends Campground	None	144	41
4172	Friends Campground	None	145	41
4173	Friends Campground	None	146	41
4174	Friends Campground	None	147	41
4175	Friends Campground	None	148	41
4176	Friends Campground	None	149	41
4177	Friends Campground	None	150	41
4178	Friends Campground	None	151	41
4179	Friends Campground	None	152	41
4180	Friends Campground	None	153	41
4181	Friends Campground	None	154	41
4182	Friends Campground	None	155	41
4183	Friends Campground	None	156	41
4184	Friends Campground	None	157	41
4185	Friends Campground	None	158	41
4186	Friends Campground	None	159	41
4187	Friends Campground	None	160	41
4188	Friends Campground	None	161	41
4189	Friends Campground	None	162	41
4190	Friends Campground	None	163	41
4191	Friends Campground	None	164	41
4192	Friends Campground	None	165	41
4193	Friends Campground	None	166	41
4194	Friends Campground	None	167	41
4195	Friends Campground	None	168	41
4196	Friends Campground	None	169	41
4197	Friends Campground	None	170	41
4198	Friends Campground	None	171	41
4199	Group Sites	None	G1 - Group	41
4200	Group Sites	None	G2 - Group	41
4201	Cove Loop Sites 1-10	None	1	42
4202	Cove Loop Sites 1-10	None	2	42
4203	Cove Loop Sites 1-10	None	3	42
4204	Cove Loop Sites 1-10	None	4	42
4205	Cove Loop Sites 1-10	None	5	42
4206	Cove Loop Sites 1-10	None	6	42
4207	Cove Loop Sites 1-10	None	7	42
4208	Cove Loop Sites 1-10	None	8	42
4209	Cove Loop Sites 1-10	None	9	42
4210	Cove Loop Sites 1-10	None	10	42
4211	Davis Creek Campground Sites 11-32	None	11	42
4212	Davis Creek Campground Sites 11-32	None	12	42
4213	Davis Creek Campground Sites 11-32	None	13	42
4214	Davis Creek Campground Sites 11-32	None	14	42
4215	Davis Creek Campground Sites 11-32	None	15	42
4216	Davis Creek Campground Sites 11-32	None	16	42
4217	Davis Creek Campground Sites 11-32	None	17	42
4218	Davis Creek Campground Sites 11-32	None	18	42
4219	Davis Creek Campground Sites 11-32	None	19	42
4220	Davis Creek Campground Sites 11-32	None	20	42
4221	Davis Creek Campground Sites 11-32	None	21	42
4222	Davis Creek Campground Sites 11-32	None	22	42
4223	Davis Creek Campground Sites 11-32	None	23	42
4224	Davis Creek Campground Sites 11-32	None	24	42
4225	Davis Creek Campground Sites 11-32	None	25	42
4226	Davis Creek Campground Sites 11-32	None	26	42
4227	Davis Creek Campground Sites 11-32	None	27	42
4228	Davis Creek Campground Sites 11-32	None	28	42
4229	Davis Creek Campground Sites 11-32	None	29	42
4230	Davis Creek Campground Sites 11-32	None	30	42
4231	Davis Creek Campground Sites 11-32	None	31	42
4232	Davis Creek Campground Sites 11-32	None	32	42
4233	None	None	33	42
4234	Group Sites	None	G1	42
4235	Campground & Group Picnic Area	None	1	43
4236	Campground & Group Picnic Area	None	2	43
4237	Campground & Group Picnic Area	None	3	43
4238	Campground & Group Picnic Area	None	4	43
4239	Campground & Group Picnic Area	None	5	43
4240	Campground & Group Picnic Area	None	6	43
4241	Campground & Group Picnic Area	None	7	43
4242	Campground & Group Picnic Area	None	8	43
4243	Campground & Group Picnic Area	None	9	43
4244	Campground & Group Picnic Area	None	10	43
4245	Campground & Group Picnic Area	None	11	43
4246	Campground & Group Picnic Area	None	12	43
4247	Campground & Group Picnic Area	None	13	43
4248	Campground & Group Picnic Area	None	14	43
4249	Campground & Group Picnic Area	None	15	43
4250	Campground & Group Picnic Area	None	16	43
4251	Campground & Group Picnic Area	None	17	43
4252	Campground & Group Picnic Area	None	18	43
4253	Campground & Group Picnic Area	None	19	43
4254	Campground & Group Picnic Area	None	20	43
4255	Campground & Group Picnic Area	None	21	43
4256	Campground & Group Picnic Area	None	22	43
4257	Campground & Group Picnic Area	None	23	43
4258	Campground & Group Picnic Area	None	24	43
4259	Campground & Group Picnic Area	None	25	43
4260	Campground & Group Picnic Area	None	26	43
4261	Campground & Group Picnic Area	None	27	43
4262	Campground & Group Picnic Area	None	28	43
4263	Campground & Group Picnic Area	None	29	43
4264	Campground & Group Picnic Area	None	30	43
4265	Campground & Group Picnic Area	None	31	43
4266	Campground & Group Picnic Area	None	32	43
4267	Campground & Group Picnic Area	None	33	43
4268	Campground & Group Picnic Area	None	34	43
4269	Campground & Group Picnic Area	None	35	43
4270	Campground & Group Picnic Area	None	36	43
4271	Campground & Group Picnic Area	None	37	43
4272	Campground & Group Picnic Area	None	38	43
4273	Campground & Group Picnic Area	None	39	43
4274	Campground & Group Picnic Area	None	40	43
4275	Campground & Group Picnic Area	None	41	43
4276	Campground & Group Picnic Area	None	42	43
4277	Campground & Group Picnic Area	None	43	43
4278	Campground & Group Picnic Area	None	44	43
4279	Campground & Group Picnic Area	None	45	43
4280	Campground & Group Picnic Area	None	46	43
4281	Campground & Group Picnic Area	None	47	43
4282	Campground & Group Picnic Area	None	48	43
4283	Campground & Group Picnic Area	None	49	43
4284	Campground & Group Picnic Area	None	50	43
4285	Campground & Group Picnic Area	None	51	43
4286	Campground & Group Picnic Area	None	52	43
4287	Campground & Group Picnic Area	None	53	43
4288	Campground & Group Picnic Area	None	54	43
4289	Campground & Group Picnic Area	None	55	43
4290	Campground & Group Picnic Area	None	56	43
4291	Campground & Group Picnic Area	None	57	43
4292	Campground & Group Picnic Area	None	58	43
4293	Campground & Group Picnic Area	None	59	43
4294	Campground & Group Picnic Area	None	60	43
4295	Campground & Group Picnic Area	None	61	43
4296	Campground & Group Picnic Area	None	62	43
4297	Campground & Group Picnic Area	None	63	43
4298	Campground & Group Picnic Area	None	64	43
4299	Campground & Group Picnic Area	None	65	43
4300	Campground & Group Picnic Area	None	66	43
4301	Campground & Group Picnic Area	None	67	43
4302	Campground & Group Picnic Area	None	68	43
4303	Campground & Group Picnic Area	None	69	43
4304	Campground & Group Picnic Area	None	70	43
4305	Campground & Group Picnic Area	None	71	43
4306	Campground & Group Picnic Area	None	72	43
4307	Campground & Group Picnic Area	None	73	43
4308	Campground & Group Picnic Area	None	74	43
4309	Campground & Group Picnic Area	None	75	43
4310	Campground & Group Picnic Area	None	76	43
4311	Campground & Group Picnic Area	None	77	43
4312	Campground & Group Picnic Area	None	78	43
4313	Campground & Group Picnic Area	None	79	43
4314	Campground & Group Picnic Area	None	80	43
4315	Campground & Group Picnic Area	None	81	43
4316	Campground & Group Picnic Area	None	82	43
4317	Campground & Group Picnic Area	None	83	43
4318	None	None	1	44
4319	None	None	2	44
4320	None	None	3	44
4321	None	None	4	44
4322	None	None	5	44
4323	None	None	6	44
4324	None	None	7	44
4325	None	None	8	44
4326	None	None	9	44
4327	None	None	10	44
4328	None	None	11	44
4329	None	None	12	44
4330	None	None	13	44
4331	None	None	14	44
4332	None	None	15	44
4333	None	None	16	44
4334	None	None	17	44
4335	None	None	18	44
4336	None	None	19	44
4337	None	None	20	44
4338	None	None	21	44
4339	None	None	22	44
4340	None	None	23	44
4341	None	None	24	44
4342	None	None	25	44
4343	None	None	26	44
4344	None	None	27	44
4345	None	None	28	44
4346	None	None	29	44
4347	None	None	30	44
4348	None	None	31	44
4349	None	None	32	44
4350	None	None	33	44
4351	None	None	34	44
4352	None	None	35	44
4353	None	None	36	44
4354	None	None	37	44
4355	None	None	38	44
4356	None	None	39	44
4357	None	None	40	44
4358	None	None	41	44
4359	None	None	42	44
4360	None	None	43	44
4361	None	None	44	44
4362	None	None	45	44
4363	None	None	46	44
4364	None	None	47	44
4365	None	None	48	44
4366	None	None	49	44
4367	None	None	50	44
4368	None	None	51	44
4369	None	None	52	44
4370	None	None	53	44
4371	None	None	54	44
4372	None	None	55	44
4373	None	None	56	44
4374	None	None	57	44
4375	None	None	58	44
4376	None	None	59	44
4377	None	None	60	44
4378	None	None	61	44
4379	None	None	62	44
4380	None	None	63	44
4381	None	None	64	44
4382	None	None	65	44
4383	None	None	66	44
4384	None	None	67	44
4385	None	None	68	44
4386	None	None	69	44
4387	None	None	70	44
4388	None	None	71	44
4389	None	None	72	44
4390	None	None	73	44
4391	None	None	74	44
4392	None	None	75	44
4393	None	None	76	44
4394	None	None	77	44
4395	None	None	78	44
4396	None	None	79	44
4397	None	None	80	44
4398	None	None	81	44
4399	None	None	82	44
4400	None	None	83	44
4401	None	None	84	44
4402	None	None	85	44
4403	None	None	86	44
4404	None	None	87	44
4405	None	None	88	44
4406	None	None	89	44
4407	None	None	90	44
4408	None	None	91	44
4409	None	None	92	44
4410	None	None	93	44
4411	None	None	94	44
4412	None	None	95	44
4413	None	None	96	44
4414	None	None	97	44
4415	None	None	98	44
4416	None	None	99	44
4417	None	None	100	44
4418	None	None	101	44
4419	None	None	102	44
4420	None	None	103	44
4421	None	None	104	44
4422	None	None	105	44
4423	None	None	106	44
4424	None	None	107	44
4425	None	None	108	44
4426	None	None	109	44
4427	None	None	110	44
4428	None	None	111	44
4429	None	None	112	44
4430	None	None	113	44
4431	None	None	114	44
4432	None	None	115	44
4433	None	None	116	44
4434	None	None	117	44
4435	None	None	118	44
4436	None	None	119	44
4437	None	None	120	44
4438	None	None	121	44
4439	None	None	122	44
4440	None	None	123	44
4441	None	None	124	44
4442	None	None	125	44
4443	None	None	126	44
4444	None	None	127	44
4445	None	None	128	44
4446	None	None	129	44
4447	None	None	130	44
4448	None	None	131	44
4449	None	None	132	44
4450	None	None	133	44
4451	None	None	134	44
4452	None	None	135	44
4453	None	None	136	44
4454	None	None	137	44
4455	None	None	138	44
4456	None	None	139	44
4457	None	None	140	44
4458	None	None	141	44
4459	None	None	142	44
4460	None	None	143	44
4461	None	None	144	44
4462	Gravel Side	None	1	45
4463	Gravel Side	None	2	45
4464	Gravel Side	None	3	45
4465	Gravel Side	None	4	45
4466	Gravel Side	None	5	45
4467	Gravel Side	None	6	45
4468	Gravel Side	None	7	45
4469	Gravel Side	None	8	45
4470	Gravel Side	None	9	45
4471	Gravel Side	None	10	45
4472	Gravel Side	None	11	45
4473	Gravel Side	None	12	45
4474	Gravel Side	None	13	45
4475	Gravel Side	None	14	45
4476	Gravel Side	None	15	45
4477	Gravel Side	None	16	45
4478	Gravel Side	None	17	45
4479	Gravel Side	None	18	45
4480	Gravel Side	None	19	45
4481	Gravel Side	None	20	45
4482	Gravel Side	None	21	45
4483	Gravel Side	None	22	45
4484	Gravel Side	None	23	45
4485	Gravel Side	None	24	45
4486	Gravel Side	None	25	45
4487	Gravel Side	None	26	45
4488	Gravel Side	None	27	45
4489	Gravel Side	None	28	45
4490	Gravel Side	None	29	45
4491	Gravel Side	None	30	45
4492	Gravel Side	None	31	45
4493	Gravel Side	None	32	45
4494	Gravel Side	None	33	45
4495	Gravel Side	None	34	45
4496	Gravel Side	None	35	45
4497	Gravel Side	None	36	45
4498	Gravel Side	None	37	45
4499	Gravel Side	None	38	45
4500	Gravel Side	None	39	45
4501	Gravel Side	None	40	45
4502	Gravel Side	None	41	45
4503	Gravel Side	None	42	45
4504	Gravel Side	None	43	45
4505	Gravel Side	None	44	45
4506	Gravel Side	None	45	45
4507	Gravel Side	None	46	45
4508	Gravel Side	None	47	45
4509	Gravel Side	None	48	45
4510	Gravel Side	None	49	45
4511	Gravel Side	None	50	45
4512	Gravel Side	None	51	45
4513	Gravel Side	None	52	45
4514	Gravel Side	None	53	45
4515	Gravel Side	None	54	45
4516	Gravel Side	None	55	45
4517	Gravel Side	None	56	45
4518	Gravel Side	None	57	45
4519	Gravel Side	None	58	45
4520	Gravel Side	None	59	45
4521	Gravel Side	None	60	45
4522	Gravel Side	None	61	45
4523	Gravel Side	None	62	45
4524	Gravel Side	None	63	45
4525	Gravel Side	None	64	45
4526	Gravel Side	None	65	45
4527	Gravel Side	None	66	45
4528	Gravel Side	None	67	45
4529	Gravel Side	None	68	45
4530	Gravel Side	None	69	45
4531	Gravel Side	None	70	45
4532	Gravel Side	None	71	45
4533	Gravel Side	None	72	45
4534	Gravel Side	None	73	45
4535	Gravel Side	None	74	45
4536	Gravel Side	None	75	45
4537	Gravel Side	None	76	45
4538	Gravel Side	None	77	45
4539	Gravel Side	None	78	45
4540	Gravel Side	None	79	45
4541	Gravel Side	None	80	45
4542	Gravel Side	None	81	45
4543	Paved Side	None	82	45
4544	Paved Side	None	83	45
4545	Paved Side	None	84	45
4546	Paved Side	None	85	45
4547	Paved Side	None	86	45
4548	Paved Side	None	87	45
4549	Paved Side	None	88	45
4550	Paved Side	None	89	45
4551	Paved Side	None	90	45
4552	Paved Side	None	91	45
4553	Paved Side	None	92	45
4554	Paved Side	None	93	45
4555	Paved Side	None	94	45
4556	Paved Side	None	95	45
4557	Paved Side	None	96	45
4558	Paved Side	None	97	45
4559	Paved Side	None	98	45
4560	Paved Side	None	99	45
4561	Paved Side	None	100	45
4562	Paved Side	None	101	45
4563	Paved Side	None	102	45
4564	Paved Side	None	103	45
4565	Paved Side	None	104	45
4566	Paved Side	None	105	45
4567	Paved Side	None	106	45
4568	Paved Side	None	107	45
4569	Paved Side	None	108	45
4570	Paved Side	None	109	45
4571	Paved Side	None	110	45
4572	Paved Side	None	111	45
4573	Paved Side	None	112	45
4574	Paved Side	None	113	45
4575	Paved Side	None	114	45
4576	Paved Side	None	115	45
4577	Paved Side	None	116	45
4578	Paved Side	None	117	45
4579	Paved Side	None	118	45
4580	Paved Side	None	119	45
4581	Paved Side	None	120	45
4582	Paved Side	None	121	45
4583	Paved Side	None	122	45
4584	Paved Side	None	123	45
4585	Paved Side	None	124	45
4586	Paved Side	None	125	45
4587	Paved Side	None	126	45
4588	Paved Side	None	127	45
4589	Paved Side	None	128	45
4590	Paved Side	None	129	45
4591	Paved Side	None	130	45
4592	Paved Side	None	131	45
4593	Paved Side	None	132	45
4594	Paved Side	None	133	45
4595	Paved Side	None	134	45
4596	Paved Side	None	135	45
4597	Paved Side	None	136	45
4598	Paved Side	None	137	45
4599	Paved Side	None	138	45
4600	Paved Side	None	139	45
4601	Paved Side	None	140	45
4602	Paved Side	None	141	45
4603	Paved Side	None	142	45
4604	Paved Side	None	143	45
4605	Paved Side	None	144	45
4606	Paved Side	None	145	45
4607	Paved Side	None	146	45
4608	Paved Side	None	147	45
4609	Paved Side	None	148	45
4610	Paved Side	None	149	45
4611	Paved Side	None	150	45
4612	Paved Side	None	151	45
4613	Paved Side	None	152	45
4614	Paved Side	None	153	45
4615	Paved Side	None	154	45
4616	Paved Side	None	155	45
4617	Paved Side	None	156	45
4618	Group Site	None	G1	45
4619	None	None	1	46
4620	None	None	2	46
4621	None	None	3	46
4622	None	None	4	46
4623	None	None	5	46
4624	None	None	6	46
4625	None	None	7	46
4626	None	None	8	46
4627	None	None	9	46
4628	None	None	10	46
4629	None	None	11	46
4630	None	None	12	46
4631	None	None	13	46
4632	None	None	14	46
4633	None	None	15	46
4634	None	None	16	46
4635	None	None	17	46
4636	None	None	18	46
4637	None	None	19	46
4638	None	None	20	46
4639	None	None	21	46
4640	None	None	22	46
4641	None	None	23	46
4642	None	None	24	46
4643	None	None	25	46
4644	None	None	26	46
4645	None	None	27	46
4646	None	None	28	46
4647	None	None	29	46
4648	None	None	30	46
4649	None	None	31	46
4650	None	None	32	46
4651	None	None	33	46
4652	None	None	34	46
4653	None	None	35	46
4654	None	None	36	46
4655	None	None	37	46
4656	None	None	38	46
4657	None	None	39	46
4658	None	None	40	46
4659	None	None	41	46
4660	None	None	42	46
4661	None	None	43	46
4662	None	None	44	46
4663	None	None	45	46
4664	None	None	46	46
4665	None	None	47	46
4666	None	None	48	46
4667	None	None	49	46
4668	None	None	50	46
4669	None	None	51	46
4670	None	None	52	46
4671	None	None	53	46
4672	Upper Campground	None	U1	47
4673	Upper Campground	None	U2	47
4674	Upper Campground	None	U3	47
4675	Upper Campground	None	U4	47
4676	Upper Campground	None	U5	47
4677	Upper Campground	None	U6	47
4678	Upper Campground	None	U7	47
4679	Upper Campground	None	U8	47
4680	Upper Campground	None	U9	47
4681	Upper Campground	None	U10	47
4682	Upper Campground	None	U11	47
4683	Upper Campground	None	U12	47
4684	Upper Campground	None	U13	47
4685	Upper Campground	None	U14	47
4686	Upper Campground	None	U15	47
4687	Upper Campground	None	U16	47
4688	Upper Campground	None	U17	47
4689	Upper Campground	None	U18	47
4690	Upper Campground	None	U19	47
4691	Upper Campground	None	U20	47
4692	Upper Campground	None	U21	47
4693	Upper Campground	None	U22	47
4694	Upper Campground	None	U23	47
4695	Upper Campground	None	U24	47
4696	Upper Campground	None	U25	47
4697	Upper Campground	None	U26	47
4698	Upper Campground	None	U27	47
4699	Upper Campground	None	U28	47
4700	Upper Campground	None	U29	47
4701	Upper Campground	None	U30	47
4702	Upper Campground	None	U31	47
4703	Upper Campground	None	U32	47
4704	Upper Campground	None	U33	47
4705	Upper Campground	None	U34	47
4706	Upper Campground	None	U35	47
4707	Upper Campground	None	U36	47
4708	Upper Campground	None	U37	47
4709	Upper Campground	None	U38	47
4710	Upper Campground	None	U39	47
4711	Upper Campground	None	U40	47
4712	Upper Campground	None	U41	47
4713	Upper Campground	None	U42	47
4714	Upper Campground	None	U43	47
4715	Upper Campground	None	U44	47
4716	Upper Campground	None	U45	47
4717	Upper Campground	None	U46	47
4718	Upper Campground	None	U47	47
4719	Upper Campground	None	U48	47
4720	Upper Campground	None	U49	47
4721	Upper Campground	None	U50	47
4722	Upper Campground	None	U51	47
4723	Upper Campground	None	U52	47
4724	Upper Campground	None	U53	47
4725	Upper Campground	None	U54	47
4726	Upper Campground	None	U55	47
4727	Lower Campground	None	L56	47
4728	Lower Campground	None	L57	47
4729	Lower Campground	None	L58	47
4730	Lower Campground	None	L59	47
4731	Lower Campground	None	L60	47
4732	Lower Campground	None	L61	47
4733	Lower Campground	None	L62	47
4734	Lower Campground	None	L63	47
4735	Lower Campground	None	L64	47
4736	Lower Campground	None	L65	47
4737	Lower Campground	None	L66	47
4738	Lower Campground	None	L67	47
4739	Lower Campground	None	L68	47
4740	Lower Campground	None	L69	47
4741	Lower Campground	None	L70	47
4742	Lower Campground	None	L71	47
4743	Lower Campground	None	L72	47
4744	Lower Campground	None	L73	47
4745	Lower Campground	None	L74	47
4746	Lower Campground	None	L75	47
4747	Lower Campground	None	L76	47
4748	Lower Campground	None	L77	47
4749	Lower Campground	None	L78	47
4750	Lower Campground	None	L79	47
4751	Lower Campground	None	L80	47
4752	Lower Campground	None	L81	47
4753	Lower Campground	None	L82	47
4754	Lower Campground	None	L83	47
4755	Lower Campground	None	L84	47
4756	Lower Campground	None	L85	47
4757	Lower Campground	None	L86	47
4758	Lower Campground	None	L87	47
4759	Lower Campground	None	L88	47
4760	Lower Campground	None	L89	47
4761	Lower Campground	None	L90	47
4762	Lower Campground	None	L91	47
4763	Lower Campground	None	L92	47
4764	Lower Campground	None	L93	47
4765	Lower Campground	None	L94	47
4766	Lower Campground	None	L95	47
4767	Lower Campground	None	L96	47
4768	None	None	T1	48
4769	None	None	T2	48
4770	None	None	T3	48
4771	None	None	G1-Group A	48
4772	None	None	G2-Group B	48
4773	None	None	1	48
4774	None	None	2	48
4775	None	None	3	48
4776	None	None	4	48
4777	None	None	5	48
4778	None	None	6	48
4779	None	None	7	48
4780	None	None	8	48
4781	None	None	9	48
4782	None	None	10	48
4783	None	None	11	48
4784	None	None	12	48
4785	None	None	13	48
4786	None	None	14	48
4787	None	None	15	48
4788	None	None	16	48
4789	None	None	17	48
4790	None	None	18	48
4791	None	None	19	48
4792	None	None	20	48
4793	None	None	21	48
4794	None	None	22	48
4795	None	None	23	48
4796	None	None	24	48
4797	None	None	25	48
4798	None	None	26	48
4799	None	None	27	48
4800	None	None	28	48
4801	None	None	29	48
4802	None	None	30	48
4803	None	None	31	48
4804	None	None	32	48
4805	None	None	33	48
4806	None	None	34	48
4807	None	None	35	48
4808	None	None	36	48
4809	None	None	37	48
4810	None	None	38	48
4811	None	None	39	48
4812	None	None	40	48
4813	None	None	41	48
4814	None	None	42	48
4815	None	None	43	48
4816	None	None	44	48
4817	None	None	45	48
4818	None	None	46	48
4819	None	None	47	48
4820	None	None	48	48
4821	None	None	49	48
4822	None	None	50	48
4823	Monashee Loop	None	M1	49
4824	Monashee Loop	None	M2	49
4825	Monashee Loop	None	M3	49
4826	Monashee Loop	None	M4	49
4827	Monashee Loop	None	M5	49
4828	Monashee Loop	None	M6	49
4829	Monashee Loop	None	M7	49
4830	Monashee Loop	None	M8	49
4831	Monashee Loop	None	M9	49
4832	Monashee Loop	None	M10	49
4833	Monashee Loop	None	M11	49
4834	Monashee Loop	None	M12	49
4835	Monashee Loop	None	M13	49
4836	Monashee Loop	None	M14	49
4837	Monashee Loop	None	M15	49
4838	Monashee Loop	None	M16	49
4839	Monashee Loop	None	M17	49
4840	Monashee Loop	None	M18	49
4841	Monashee Loop	None	M19	49
4842	Monashee Loop	None	M20	49
4843	Monashee Loop	None	M21	49
4844	Monashee Loop	None	M22	49
4845	Monashee Loop	None	M23	49
4846	Monashee Loop	None	M24	49
4847	Monashee Loop	None	M25	49
4848	Monashee Loop	None	M26	49
4849	Monashee Loop	None	M27	49
4850	Monashee Loop	None	M28	49
4851	Monashee Loop	None	M29	49
4852	Monashee Loop	None	M30	49
4853	Trinity Loop	None	T37	49
4854	Trinity Loop	None	T38	49
4855	Trinity Loop	None	T39	49
4856	Trinity Loop	None	T40	49
4857	Trinity Loop	None	T41	49
4858	Trinity Loop	None	T42	49
4859	Trinity Loop	None	T43	49
4860	Trinity Loop	None	T44	49
4861	Trinity Loop	None	T45	49
4862	Trinity Loop	None	T46	49
4863	Trinity Loop	None	T47	49
4864	Trinity Loop	None	T48	49
4865	Trinity Loop	None	T49	49
4866	Trinity Loop	None	T50	49
4867	Trinity Loop	None	T51	49
4868	Trinity Loop	None	T52	49
4869	Trinity Loop	None	T53	49
4870	Trinity Loop	None	T54	49
4871	Trinity Loop	None	T55	49
4872	Trinity Loop	None	T56	49
4873	Trinity Loop	None	T57	49
4874	Trinity Loop	None	T58	49
4875	Trinity Loop	None	T59	49
4876	Trinity Loop	None	T60	49
4877	Trinity Loop	None	T61	49
4878	Trinity Loop	None	T62	49
4879	Trinity Loop	None	T63	49
4880	Trinity Loop	None	T64	49
4881	Trinity Loop	None	T65	49
4882	Trinity Loop	None	T66	49
4883	Trinity Loop	None	T67	49
4884	Trinity Loop	None	T68	49
4885	Trinity Loop	None	T69	49
4886	Trinity Loop	None	T70	49
4887	Trinity Loop	None	T71	49
4888	Trinity Loop	None	T72	49
4889	Trinity Loop	None	T73	49
4890	Trinity Loop	None	T74	49
4891	Trinity Loop	None	T75	49
4892	Trinity Loop	None	T76	49
4893	Trinity Loop	None	T77	49
4894	Trinity Loop	None	T78	49
4895	Trinity Loop	None	T79	49
4896	Trinity Loop	None	T80	49
4897	Trinity Loop	None	T81	49
4898	Trinity Loop	None	T82	49
4899	Trinity Loop	None	T83	49
4900	Trinity Loop	None	T84	49
4901	Group Site	None	G1	49
4902	Taylor Creek Loop	None	TC85	49
4903	Taylor Creek Loop	None	TC86	49
4904	Taylor Creek Loop	None	TC87	49
4905	Taylor Creek Loop	None	TC88	49
4906	Taylor Creek Loop	None	TC89	49
4907	Taylor Creek Loop	None	TC90	49
4908	Taylor Creek Loop	None	TC91	49
4909	Taylor Creek Loop	None	TC92	49
4910	Taylor Creek Loop	None	TC93	49
4911	Taylor Creek Loop	None	TC94	49
4912	Taylor Creek Loop	None	TC95	49
4913	Taylor Creek Loop	None	TC96	49
4914	Taylor Creek Loop	None	TC97	49
4915	Taylor Creek Loop	None	TC98	49
4916	Taylor Creek Loop	None	TC99	49
4917	Taylor Creek Loop	None	TC100	49
4918	Taylor Creek Loop	None	TC101	49
4919	Taylor Creek Loop	None	TC102	49
4920	Taylor Creek Loop	None	TC103	49
4921	Taylor Creek Loop	None	TC104	49
4922	Taylor Creek Loop	None	TC105	49
4923	Taylor Creek Loop	None	TC106	49
4924	Taylor Creek Loop	None	TC107	49
4925	Taylor Creek Loop	None	TC108	49
4926	Taylor Creek Loop	None	TC109	49
4927	Taylor Creek Loop	None	TC110	49
4928	Taylor Creek Loop	None	TC111	49
4929	Taylor Creek Loop	None	TC112	49
4930	Taylor Creek Loop	None	TC113	49
4931	Taylor Creek Loop	None	TC114	49
4932	Sites 1-47	None	1	50
4933	Sites 1-47	None	2	50
4934	Sites 1-47	None	3	50
4935	Sites 1-47	None	4	50
4936	Sites 1-47	None	5	50
4937	Sites 1-47	None	6	50
4938	Sites 1-47	None	7	50
4939	Sites 1-47	None	8	50
4940	Sites 1-47	None	9	50
4941	Sites 1-47	None	10	50
4942	Sites 1-47	None	11	50
4943	Sites 1-47	None	12	50
4944	Sites 1-47	None	13	50
4945	Sites 1-47	None	14	50
4946	Sites 1-47	None	15	50
4947	Sites 1-47	None	16	50
4948	Sites 1-47	None	17	50
4949	Sites 1-47	None	18	50
4950	Sites 1-47	None	19	50
4951	Sites 1-47	None	20	50
4952	Sites 1-47	None	21	50
4953	Sites 1-47	None	22	50
4954	Sites 1-47	None	23	50
4955	Sites 1-47	None	24	50
4956	Sites 1-47	None	25	50
4957	Sites 1-47	None	26	50
4958	Sites 1-47	None	27	50
4959	Sites 1-47	None	28	50
4960	Sites 1-47	None	29	50
4961	Sites 1-47	None	30	50
4962	Sites 1-47	None	31	50
4963	Sites 1-47	None	32	50
4964	Sites 1-47	None	33	50
4965	Sites 1-47	None	34	50
4966	Sites 1-47	None	35	50
4967	Sites 1-47	None	36	50
4968	Sites 1-47	None	37	50
4969	Sites 1-47	None	38	50
4970	Sites 1-47	None	39	50
4971	Sites 1-47	None	40	50
4972	Sites 1-47	None	41	50
4973	Sites 1-47	None	42	50
4974	Sites 1-47	None	43	50
4975	Sites 1-47	None	44	50
4976	Sites 1-47	None	45	50
4977	Sites 1-47	None	46	50
4978	Sites 1-47	None	47	50
4979	Sites 1-47	None	S1	50
4980	Sites 48-76	None	48	50
4981	Sites 48-76	None	49	50
4982	Sites 48-76	None	50	50
4983	Sites 48-76	None	51	50
4984	Sites 48-76	None	52	50
4985	Sites 48-76	None	53	50
4986	Sites 48-76	None	54	50
4987	Sites 48-76	None	55	50
4988	Sites 48-76	None	56	50
4989	Sites 48-76	None	57	50
4990	Sites 48-76	None	58	50
4991	Sites 48-76	None	59	50
4992	Sites 48-76	None	60	50
4993	Sites 48-76	None	61	50
4994	Sites 48-76	None	62	50
4995	Sites 48-76	None	63	50
4996	Sites 48-76	None	64	50
4997	Sites 48-76	None	65	50
4998	Sites 48-76	None	66	50
4999	Sites 48-76	None	67	50
5000	Sites 48-76	None	68	50
5001	Sites 48-76	None	69	50
5002	Sites 48-76	None	70	50
5003	Sites 48-76	None	71	50
5004	Sites 48-76	None	72	50
5005	Sites 48-76	None	73	50
5006	Sites 48-76	None	74	50
5007	Sites 48-76	None	75	50
5008	Sites 48-76	None	76	50
5009	Sites 1-18	None	1	51
5010	Sites 1-18	None	2	51
5011	Sites 1-18	None	3	51
5012	Sites 1-18	None	4	51
5013	Sites 1-18	None	5	51
5014	Sites 1-18	None	6	51
5015	Sites 1-18	None	7	51
5016	Sites 1-18	None	8	51
5017	Sites 1-18	None	9	51
5018	Sites 1-18	None	10	51
5019	Sites 1-18	None	11	51
5020	Sites 1-18	None	12	51
5021	Sites 1-18	None	13	51
5022	Sites 1-18	None	14	51
5023	Sites 1-18	None	15	51
5024	Sites 1-18	None	16	51
5025	Sites 1-18	None	17	51
5026	Sites 1-18	None	18	51
5027	Sites 19-39	None	19	51
5028	Sites 19-39	None	20	51
5029	Sites 19-39	None	21	51
5030	Sites 19-39	None	22	51
5031	Sites 19-39	None	23	51
5032	Sites 19-39	None	24	51
5033	Sites 19-39	None	25	51
5034	Sites 19-39	None	26	51
5035	Sites 19-39	None	27	51
5036	Sites 19-39	None	28	51
5037	Sites 19-39	None	29	51
5038	Sites 19-39	None	30	51
5039	Sites 19-39	None	31	51
5040	Sites 19-39	None	32	51
5041	Sites 19-39	None	33	51
5042	Sites 19-39	None	34	51
5043	Sites 19-39	None	35	51
5044	Sites 19-39	None	36	51
5045	Sites 19-39	None	37	51
5046	Sites 19-39	None	38	51
5047	Sites 19-39	None	39	51
5048	Sites 40-73	None	40	51
5049	Sites 40-73	None	41	51
5050	Sites 40-73	None	42	51
5051	Sites 40-73	None	43	51
5052	Sites 40-73	None	44	51
5053	Sites 40-73	None	45	51
5054	Sites 40-73	None	46	51
5055	Sites 40-73	None	47	51
5056	Sites 40-73	None	48	51
5057	Sites 40-73	None	49	51
5058	Sites 40-73	None	50	51
5059	Sites 40-73	None	51	51
5060	Sites 40-73	None	52	51
5061	Sites 40-73	None	53	51
5062	Sites 40-73	None	54	51
5063	Sites 40-73	None	55	51
5064	Sites 40-73	None	56	51
5065	Sites 40-73	None	57	51
5066	Sites 40-73	None	58	51
5067	Sites 40-73	None	59	51
5068	Sites 40-73	None	60	51
5069	Sites 40-73	None	61	51
5070	Sites 40-73	None	62	51
5071	Sites 40-73	None	63	51
5072	Sites 40-73	None	64	51
5073	Sites 40-73	None	65	51
5074	Sites 40-73	None	66	51
5075	Sites 40-73	None	67	51
5076	Sites 40-73	None	68	51
5077	Sites 40-73	None	69	51
5078	Sites 40-73	None	70	51
5079	Sites 40-73	None	71	51
5080	Sites 40-73	None	72	51
5081	Sites 40-73	None	73	51
5082	None	None	126	52
5083	None	None	127	52
5084	None	None	128	52
5085	None	None	129	52
5086	None	None	130	52
5087	None	None	131	52
5088	None	None	132	52
5089	None	None	133	52
5090	None	None	134	52
5091	None	None	135	52
5092	None	None	136	52
5093	None	None	137	52
5094	None	None	138	52
5095	None	None	139	52
5096	None	None	140	52
5097	None	None	141	52
5098	None	None	142	52
5099	None	None	143	52
5100	None	None	144	52
5101	None	None	145	52
5102	None	None	146	52
5103	None	None	147	52
5104	None	None	148	52
5105	None	None	149	52
5106	None	None	150	52
5107	None	None	151	52
5108	None	None	152	52
5109	None	None	153	52
5110	None	None	154	52
5111	None	None	155	52
5112	None	None	156	52
5113	None	None	157	52
5114	None	None	158	52
5115	None	None	159	52
5116	None	None	160	52
5117	None	None	161	52
5118	None	None	162	52
5119	None	None	163	52
5120	None	None	164	52
5121	None	None	165	52
5122	None	None	166	52
5123	None	None	167	52
5124	None	None	168	52
5125	None	None	169	52
5126	None	None	170	52
5127	None	None	171	52
5128	None	None	172	52
5129	None	None	173	52
5130	None	None	174	52
5131	None	None	175	52
5132	None	None	176	52
5133	None	None	177	52
5134	None	None	178	52
5135	None	None	179	52
5136	None	None	180	52
5137	None	None	181	52
5138	None	None	182	52
5139	None	None	183	52
5140	None	None	184	52
5141	None	None	185	52
5142	None	None	186	52
5143	None	None	187	52
5144	None	None	188	52
5145	None	None	189	52
5146	None	None	190	52
5147	None	None	191	52
5148	None	None	192	52
5149	None	None	193	52
5150	None	None	194	52
5151	None	None	195	52
5152	None	None	196	52
5153	None	None	197	52
5154	None	None	198	52
5155	None	None	199	52
5156	None	None	200	52
5157	None	None	201	52
5158	None	None	G1-Group	52
5159	None	None	1	53
5160	None	None	2	53
5161	None	None	3	53
5162	None	None	4	53
5163	None	None	12	53
5164	None	None	13	53
5165	None	None	14	53
5166	None	None	15	53
5167	None	None	16	53
5168	None	None	17	53
5169	None	None	18	53
5170	None	None	19	53
5171	None	None	20	53
5172	None	None	35	53
5173	None	None	36	53
5174	None	None	37	53
5175	None	None	38	53
5176	None	None	39	53
5177	None	None	40	53
5178	None	None	41	53
5179	None	None	42	53
5180	None	None	53	53
5181	None	None	54	53
5182	None	None	55	53
5183	None	None	56	53
5184	None	None	57	53
5185	None	None	58	53
5186	None	None	59	53
5187	None	None	60	53
5188	None	None	61	53
5189	None	None	62	53
5190	None	None	63	53
5191	None	None	64	53
5192	None	None	65	53
5193	None	None	66	53
5194	None	None	67	53
5195	None	None	68	53
5196	None	None	69	53
5197	None	None	70	53
5198	None	None	71	53
5199	None	None	72	53
5200	None	None	82	53
5201	None	None	83	53
5202	None	None	84	53
5203	None	None	85	53
5204	None	None	86	53
5205	None	None	87	53
5206	None	None	88	53
5207	None	None	89	53
5208	None	None	90	53
5209	None	None	91	53
5210	None	None	92	53
5211	None	None	93	53
5212	None	None	94	53
5213	None	None	95	53
5214	None	None	96	53
5215	None	None	97	53
5216	None	None	98	53
5217	None	None	99	53
5218	None	None	100	53
5219	None	None	101	53
5220	None	None	102	53
5221	None	None	103	53
5222	None	None	104	53
5223	None	None	105	53
5224	A (Sites 1-30)	None	1	54
5225	A (Sites 1-30)	None	2	54
5226	A (Sites 1-30)	None	3	54
5227	A (Sites 1-30)	None	4	54
5228	A (Sites 1-30)	None	5	54
5229	A (Sites 1-30)	None	6	54
5230	A (Sites 1-30)	None	7	54
5231	A (Sites 1-30)	None	8	54
5232	A (Sites 1-30)	None	9	54
5233	A (Sites 1-30)	None	10	54
5234	A (Sites 1-30)	None	11	54
5235	A (Sites 1-30)	None	12	54
5236	A (Sites 1-30)	None	13	54
5237	A (Sites 1-30)	None	14	54
5238	A (Sites 1-30)	None	15	54
5239	A (Sites 1-30)	None	16	54
5240	A (Sites 1-30)	None	17	54
5241	A (Sites 1-30)	None	18	54
5242	A (Sites 1-30)	None	19	54
5243	A (Sites 1-30)	None	20	54
5244	A (Sites 1-30)	None	21	54
5245	A (Sites 1-30)	None	22	54
5246	A (Sites 1-30)	None	23	54
5247	A (Sites 1-30)	None	24	54
5248	A (Sites 1-30)	None	25	54
5249	A (Sites 1-30)	None	26	54
5250	A (Sites 1-30)	None	27	54
5251	A (Sites 1-30)	None	28	54
5252	A (Sites 1-30)	None	29	54
5253	A (Sites 1-30)	None	30	54
5254	B (Sites 31-58, 111-132)	None	31	54
5255	B (Sites 31-58, 111-132)	None	32	54
5256	B (Sites 31-58, 111-132)	None	33	54
5257	B (Sites 31-58, 111-132)	None	34	54
5258	B (Sites 31-58, 111-132)	None	35	54
5259	B (Sites 31-58, 111-132)	None	36	54
5260	B (Sites 31-58, 111-132)	None	37	54
5261	B (Sites 31-58, 111-132)	None	38	54
5262	B (Sites 31-58, 111-132)	None	39	54
5263	B (Sites 31-58, 111-132)	None	40	54
5264	B (Sites 31-58, 111-132)	None	41	54
5265	B (Sites 31-58, 111-132)	None	42	54
5266	B (Sites 31-58, 111-132)	None	43	54
5267	B (Sites 31-58, 111-132)	None	44	54
5268	B (Sites 31-58, 111-132)	None	45	54
5269	B (Sites 31-58, 111-132)	None	46	54
5270	B (Sites 31-58, 111-132)	None	47	54
5271	B (Sites 31-58, 111-132)	None	48	54
5272	B (Sites 31-58, 111-132)	None	49	54
5273	B (Sites 31-58, 111-132)	None	50	54
5274	B (Sites 31-58, 111-132)	None	51	54
5275	B (Sites 31-58, 111-132)	None	52	54
5276	B (Sites 31-58, 111-132)	None	53	54
5277	B (Sites 31-58, 111-132)	None	54	54
5278	B (Sites 31-58, 111-132)	None	55	54
5279	B (Sites 31-58, 111-132)	None	56	54
5280	B (Sites 31-58, 111-132)	None	57	54
5281	B (Sites 31-58, 111-132)	None	58	54
5282	B (Sites 31-58, 111-132)	None	111	54
5283	B (Sites 31-58, 111-132)	None	112	54
5284	B (Sites 31-58, 111-132)	None	113	54
5285	B (Sites 31-58, 111-132)	None	114	54
5286	B (Sites 31-58, 111-132)	None	115	54
5287	B (Sites 31-58, 111-132)	None	116	54
5288	B (Sites 31-58, 111-132)	None	117	54
5289	B (Sites 31-58, 111-132)	None	118	54
5290	B (Sites 31-58, 111-132)	None	119	54
5291	B (Sites 31-58, 111-132)	None	120	54
5292	B (Sites 31-58, 111-132)	None	121	54
5293	B (Sites 31-58, 111-132)	None	122	54
5294	B (Sites 31-58, 111-132)	None	123	54
5295	B (Sites 31-58, 111-132)	None	124	54
5296	B (Sites 31-58, 111-132)	None	125	54
5297	B (Sites 31-58, 111-132)	None	126	54
5298	B (Sites 31-58, 111-132)	None	127	54
5299	B (Sites 31-58, 111-132)	None	128	54
5300	B (Sites 31-58, 111-132)	None	129	54
5301	B (Sites 31-58, 111-132)	None	130	54
5302	B (Sites 31-58, 111-132)	None	131	54
5303	B (Sites 31-58, 111-132)	None	132	54
5304	C (Sites 59-110)	None	59	54
5305	C (Sites 59-110)	None	60	54
5306	C (Sites 59-110)	None	61	54
5307	C (Sites 59-110)	None	62	54
5308	C (Sites 59-110)	None	63	54
5309	C (Sites 59-110)	None	64	54
5310	C (Sites 59-110)	None	65	54
5311	C (Sites 59-110)	None	66	54
5312	C (Sites 59-110)	None	67	54
5313	C (Sites 59-110)	None	68	54
5314	C (Sites 59-110)	None	69	54
5315	C (Sites 59-110)	None	70	54
5316	C (Sites 59-110)	None	71	54
5317	C (Sites 59-110)	None	72	54
5318	C (Sites 59-110)	None	73	54
5319	C (Sites 59-110)	None	74	54
5320	C (Sites 59-110)	None	75	54
5321	C (Sites 59-110)	None	76	54
5322	C (Sites 59-110)	None	77	54
5323	C (Sites 59-110)	None	78	54
5324	C (Sites 59-110)	None	79	54
5325	C (Sites 59-110)	None	80	54
5326	C (Sites 59-110)	None	81	54
5327	C (Sites 59-110)	None	82	54
5328	C (Sites 59-110)	None	83	54
5329	C (Sites 59-110)	None	84	54
5330	C (Sites 59-110)	None	85	54
5331	C (Sites 59-110)	None	86	54
5332	C (Sites 59-110)	None	87	54
5333	C (Sites 59-110)	None	88	54
5334	C (Sites 59-110)	None	89	54
5335	C (Sites 59-110)	None	90	54
5336	C (Sites 59-110)	None	91	54
5337	C (Sites 59-110)	None	92	54
5338	C (Sites 59-110)	None	93	54
5339	C (Sites 59-110)	None	94	54
5340	C (Sites 59-110)	None	95	54
5341	C (Sites 59-110)	None	96	54
5342	C (Sites 59-110)	None	97	54
5343	C (Sites 59-110)	None	98	54
5344	C (Sites 59-110)	None	99	54
5345	C (Sites 59-110)	None	100	54
5346	C (Sites 59-110)	None	101	54
5347	C (Sites 59-110)	None	102	54
5348	C (Sites 59-110)	None	103	54
5349	C (Sites 59-110)	None	104	54
5350	C (Sites 59-110)	None	105	54
5351	C (Sites 59-110)	None	106	54
5352	C (Sites 59-110)	None	107	54
5353	C (Sites 59-110)	None	108	54
5354	C (Sites 59-110)	None	109	54
5355	C (Sites 59-110)	None	110	54
5356	None	None	22	55
5357	None	None	23	55
5358	None	None	24	55
5359	None	None	25	55
5360	None	None	26	55
5361	None	None	27	55
5362	None	None	28	55
5363	None	None	29	55
5364	None	None	30	55
5365	None	None	31	55
5366	None	None	32	55
5367	None	None	33	55
5368	None	None	34	55
5369	None	None	35	55
5370	None	None	36	55
5371	None	None	37	55
5372	None	None	38	55
5373	None	None	39	55
5374	None	None	40	55
5375	None	None	41	55
5376	None	None	42	55
5377	None	None	43	55
5378	None	None	44	55
5379	None	None	G1 - Group	55
5380	None	None	1	56
5381	None	None	2	56
5382	None	None	3	56
5383	None	None	7	56
5384	None	None	8	56
5385	None	None	9	56
5386	None	None	10	56
5387	None	None	11	56
5388	None	None	12	56
5389	None	None	13	56
5390	None	None	14	56
5391	None	None	15	56
5392	None	None	16	56
5393	None	None	17	56
5394	None	None	18	56
5395	None	None	1	57
5396	None	None	2	57
5397	None	None	3	57
5398	None	None	4	57
5399	None	None	5	57
5400	None	None	6	57
5401	None	None	7	57
5402	None	None	8	57
5403	None	None	9	57
5404	None	None	10	57
5405	None	None	11	57
5406	None	None	12	57
5407	None	None	13	57
5408	None	None	14	57
5409	None	None	15	57
5410	None	None	16	57
5411	None	None	17	57
5412	None	None	18	57
5413	None	None	19	57
5414	None	None	20	57
5415	None	None	32	57
5416	None	None	33	57
5417	None	None	34	57
5418	None	None	35	57
5419	None	None	36	57
5420	None	None	37	57
5421	None	None	38	57
5422	None	None	39	57
5423	None	None	40	57
5424	None	None	41	57
5425	None	None	42	57
5426	None	None	43	57
5427	None	None	44	57
5428	None	None	47	57
5429	None	None	48	57
5430	None	None	49	57
5431	None	None	50	57
5432	None	None	51	57
5433	None	None	52	57
5434	None	None	53	57
5435	None	None	54	57
5436	None	None	55	57
5437	None	None	56	57
5438	None	None	57	57
5439	None	None	58	57
5440	None	None	62	57
5441	None	None	63	57
5442	None	None	64	57
5443	None	None	65	57
5444	None	None	66	57
5445	None	None	67	57
5446	None	None	68	57
5447	Robson Meadows Campground	None	11	58
5448	Robson Meadows Campground	None	12	58
5449	Robson Meadows Campground	None	13	58
5450	Robson Meadows Campground	None	14	58
5451	Robson Meadows Campground	None	15	58
5452	Robson Meadows Campground	None	16	58
5453	Robson Meadows Campground	None	17	58
5454	Robson Meadows Campground	None	18	58
5455	Robson Meadows Campground	None	19	58
5456	Robson Meadows Campground	None	20	58
5457	Robson Meadows Campground	None	21	58
5458	Robson Meadows Campground	None	22	58
5459	Robson Meadows Campground	None	23	58
5460	Robson Meadows Campground	None	24	58
5461	Robson Meadows Campground	None	25	58
5462	Robson Meadows Campground	None	26	58
5463	Robson Meadows Campground	None	27	58
5464	Robson Meadows Campground	None	28	58
5465	Robson Meadows Campground	None	29	58
5466	Robson Meadows Campground	None	30	58
5467	Robson Meadows Campground	None	31	58
5468	Robson Meadows Campground	None	32	58
5469	Robson Meadows Campground	None	33	58
5470	Robson Meadows Campground	None	34	58
5471	Robson Meadows Campground	None	35	58
5472	Robson Meadows Campground	None	36	58
5473	Robson Meadows Campground	None	37	58
5474	Robson Meadows Campground	None	38	58
5475	Robson Meadows Campground	None	39	58
5476	Robson Meadows Campground	None	40	58
5477	Robson Meadows Campground	None	41	58
5478	Robson Meadows Campground	None	42	58
5479	Robson Meadows Campground	None	43	58
5480	Robson Meadows Campground	None	44	58
5481	Robson Meadows Campground	None	45	58
5482	Robson Meadows Campground	None	46	58
5483	Robson Meadows Campground	None	47	58
5484	Robson Meadows Campground	None	48	58
5485	Robson Meadows Campground	None	49	58
5486	Robson Meadows Campground	None	50	58
5487	Robson Meadows Campground	None	51	58
5488	Robson Meadows Campground	None	52	58
5489	Robson Meadows Campground	None	53	58
5490	Robson Meadows Campground	None	54	58
5491	Robson Meadows Campground	None	55	58
5492	Robson Meadows Campground	None	56	58
5493	Robson Meadows Campground	None	57	58
5494	Robson Meadows Campground	None	58	58
5495	Robson Meadows Campground	None	59	58
5496	Robson Meadows Campground	None	60	58
5497	Robson Meadows Campground	None	61	58
5498	Robson Meadows Campground	None	62	58
5499	Robson Meadows Campground	None	63	58
5500	Robson Meadows Campground	None	64	58
5501	Robson Meadows Campground	None	65	58
5502	Robson Meadows Campground	None	66	58
5503	Robson Meadows Campground	None	67	58
5504	Robson Meadows Campground	None	68	58
5505	Robson Meadows Campground	None	69	58
5506	Robson Meadows Campground	None	80	58
5507	Robson Meadows Campground	None	81	58
5508	Robson Meadows Campground	None	82	58
5509	Robson Meadows Campground	None	83	58
5510	Robson Meadows Campground	None	84	58
5511	Robson Meadows Campground	None	85	58
5512	Robson Meadows Campground	None	86	58
5513	Robson Meadows Campground	None	87	58
5514	Robson Meadows Campground	None	88	58
5515	Robson Meadows Campground	None	89	58
5516	Robson Meadows Campground	None	90	58
5517	Robson Meadows Campground	None	91	58
5518	Robson Meadows Campground	None	92	58
5519	Robson Meadows Campground	None	93	58
5520	Robson Meadows Campground	None	94	58
5521	Robson Meadows Campground	None	95	58
5522	Robson Meadows Campground	None	96	58
5523	Robson Meadows Campground	None	97	58
5524	Robson Meadows Campground	None	98	58
5525	Robson Meadows Campground	None	99	58
5526	Robson Meadows Campground	None	100	58
5527	Robson Meadows Campground	None	101	58
5528	Robson Meadows Campground	None	102	58
5529	Robson Meadows Campground	None	103	58
5530	Robson Meadows Campground	None	104	58
5531	Robson Meadows Campground	None	105	58
5532	Robson Meadows Campground	None	106	58
5533	Robson Meadows Campground	None	107	58
5534	Robson Meadows Campground	None	108	58
5535	Robson Meadows Campground	None	109	58
5536	Robson Meadows Campground	None	110	58
5537	Robson Meadows Campground	None	111	58
5538	Robson Meadows Campground	None	112	58
5539	Robson Meadows Campground	None	113	58
5540	Robson Meadows Campground	None	114	58
5541	Robson Meadows Campground	None	115	58
5542	Robson Meadows Campground	None	116	58
5543	Robson Meadows Campground	None	117	58
5544	Robson Meadows Campground	None	118	58
5545	Robson Meadows Campground	None	119	58
5546	Robson Meadows Campground	None	120	58
5547	Robson Meadows Campground	None	121	58
5548	Robson Meadows Campground	None	122	58
5549	Robson Meadows Campground	None	123	58
5550	Robson Meadows Campground	None	124	58
5551	Robson Meadows Campground	None	125	58
5552	Robson Meadows Campground	None	G1	58
5553	Robson River Campground	None	R1	58
5554	Robson River Campground	None	R2	58
5555	Robson River Campground	None	R3	58
5556	Robson River Campground	None	R4	58
5557	Robson River Campground	None	R5	58
5558	Robson River Campground	None	R6	58
5559	Robson River Campground	None	R7	58
5560	Robson River Campground	None	R8	58
5561	Robson River Campground	None	R9	58
5562	Robson River Campground	None	R10	58
5563	Robson River Campground	None	R11	58
5564	Robson River Campground	None	R12	58
5565	Robson River Campground	None	R13	58
5566	Robson River Campground	None	R14	58
5567	Robson River Campground	None	R15	58
5568	Robson River Campground	None	R16	58
5569	Robson River Campground	None	R17	58
5570	Robson River Campground	None	R18	58
5571	Robson River Campground	None	R20	58
5572	Robson River Campground	None	R21	58
5573	Robson River Campground	None	R22	58
5574	Robson River Campground	None	R23	58
5575	Robson River Campground	None	R24	58
5576	Robson River Campground	None	R25	58
5577	Robson River Campground	None	R26	58
5578	Robson River Campground	None	R27	58
5579	Robson River Campground	None	R28	58
5580	Robson River Campground	None	R29	58
5581	Robson River Campground	None	R30	58
5582	Robson River Campground	None	R31	58
5583	Robson River Campground	None	R32	58
5584	Robson River Campground	None	R33	58
5585	Robson River Campground	None	R34	58
5586	Robson River Campground	None	R35	58
5587	Robson River Campground	None	R36	58
5588	Robson River Campground	None	R37	58
5589	Robson River Campground	None	R38	58
5590	Robson River Campground	None	R39	58
5591	Robson River Campground	None	R40	58
5592	Robson River Campground	None	R41	58
5593	Lucerne Campground	None	L7	58
5594	Lucerne Campground	None	L8	58
5595	Lucerne Campground	None	L9	58
5596	Lucerne Campground	None	L10	58
5597	Lucerne Campground	None	L11	58
5598	Lucerne Campground	None	L12	58
5599	Lucerne Campground	None	L13	58
5600	Lucerne Campground	None	L14	58
5601	Lucerne Campground	None	L15	58
5602	Lucerne Campground	None	L16	58
5603	Lucerne Campground	None	L17	58
5604	Lucerne Campground	None	L18	58
5605	Lucerne Campground	None	L19	58
5606	Lucerne Campground	None	L20	58
5607	Lucerne Campground	None	L21	58
5608	Lucerne Campground	None	L22	58
5609	Lucerne Campground	None	L23	58
5610	Lucerne Campground	None	L24	58
5611	Lucerne Campground	None	L25	58
5612	Lucerne Campground	None	L26	58
5613	Lucerne Campground	None	L27	58
5614	Lucerne Campground	None	L28	58
5615	Lucerne Campground	None	L29	58
5616	Lucerne Campground	None	L30	58
5617	Lucerne Campground	None	L31	58
5618	Lucerne Campground	None	L32	58
5619	Lucerne Campground	None	L33	58
5620	Lucerne Campground	None	L34	58
5621	Lucerne Campground	None	L35	58
5622	Lucerne Campground	None	L36	58
5623	Lucerne Campground	None	LA	58
5624	Lucerne Campground	None	LB	58
5625	Campground	None	25	59
5626	Campground	None	26	59
5627	Campground	None	27	59
5628	Campground	None	28	59
5629	Campground	None	29	59
5630	Campground	None	30	59
5631	Campground	None	31	59
5632	Campground	None	32	59
5633	Campground	None	33	59
5634	Campground	None	34	59
5635	Campground	None	35	59
5636	Campground	None	36	59
5637	Campground	None	37	59
5638	Campground	None	38	59
5639	Campground	None	39	59
5640	Campground	None	40	59
5641	Campground	None	41	59
5642	Campground	None	42	59
5643	Campground	None	43	59
5644	Campground	None	44	59
5645	Campground	None	45	59
5646	Campground	None	46	59
5647	Campground	None	47	59
5648	Campground	None	48	59
5649	Campground	None	49	59
5650	Campground	None	50	59
5651	Campground	None	51	59
5652	Campground	None	82	59
5653	Campground	None	83	59
5654	Campground	None	84	59
5655	Campground	None	85	59
5656	Campground	None	86	59
5657	Campground	None	87	59
5658	Campground	None	88	59
5659	Campground	None	89	59
5660	Campground	None	90	59
5661	Campground	None	91	59
5662	Campground	None	92	59
5663	Campground	None	93	59
5664	Campground	None	94	59
5665	Campground	None	95	59
5666	Campground	None	96	59
5667	Campground	None	97	59
5668	Campground	None	98	59
5669	Campground	None	99	59
5670	Campground	None	100	59
5671	Campground	None	101	59
5672	Campground	None	102	59
5673	Campground	None	103	59
5674	Campground	None	104	59
5675	Campground	None	105	59
5676	Campground	None	106	59
5677	Campground	None	107	59
5678	Campground	None	108	59
5679	Campground	None	109	59
5680	Campground	None	110	59
5681	Campground	None	111	59
5682	None	None	1	61
5683	None	None	2	61
5684	None	None	3	61
5685	None	None	4	61
5686	None	None	5	61
5687	None	None	6	61
5688	None	None	7	61
5689	None	None	8	61
5690	None	None	9	61
5691	None	None	10	61
5692	None	None	11	61
5693	None	None	12	61
5694	None	None	13	61
5695	None	None	14	61
5696	None	None	15	61
5697	None	None	16	61
5698	None	None	17	61
5699	None	None	18	61
5700	None	None	19	61
5701	None	None	20	61
5702	None	None	21	61
5703	None	None	22	61
5704	None	None	23	61
5705	None	None	24	61
5706	None	None	25	61
5707	None	None	26	61
5708	None	None	27	61
5709	None	None	28	61
5710	None	None	29	61
5711	None	None	30	61
5712	None	None	31	61
5713	None	None	32	61
5714	None	None	33	61
5715	None	None	34	61
5716	None	None	35	61
5717	None	None	36	61
5718	None	None	37	61
5719	None	None	38	61
5720	None	None	39	61
5721	None	None	40	61
5722	None	None	41	61
5723	None	None	42	61
5724	None	None	43	61
5725	None	None	44	61
5726	None	None	45	61
5727	None	None	46	61
5728	None	None	47	61
5729	None	None	48	61
5730	None	None	49	61
5731	None	None	50	61
5732	None	None	51	61
5733	None	None	52	61
5734	None	None	53	61
5735	None	None	54	61
5736	None	None	55	61
5737	None	None	56	61
5738	None	None	57	61
5739	None	None	58	61
5740	None	None	59	61
5741	None	None	60	61
5742	None	None	61	61
5743	None	None	62	61
5744	None	None	63	61
5745	None	None	64	61
5746	None	None	65	61
5747	None	None	66	61
5748	None	None	67	61
5749	None	None	68	61
5750	None	None	69	61
5751	None	None	70	61
5752	None	None	71	61
5753	None	None	72	61
5754	None	None	73	61
5755	None	None	74	61
5756	None	None	75	61
5757	None	None	76	61
5758	None	None	77	61
5759	None	None	78	61
5760	None	None	79	61
5761	None	None	80	61
5762	None	None	81	61
5763	None	None	82	61
5764	None	None	83	61
5765	None	None	84	61
5766	None	None	85	61
5767	None	None	86	61
5768	None	None	87	61
5769	None	None	88	61
5770	None	None	89	61
5771	None	None	90	61
5772	None	None	91	61
5773	None	None	92	61
5774	None	None	93	61
5775	None	None	94	61
5776	Campground	None	1	62
5777	Campground	None	2	62
5778	Campground	None	3	62
5779	Campground	None	4	62
5780	Campground	None	5	62
5781	Campground	None	6	62
5782	Campground	None	7	62
5783	Campground	None	8	62
5784	Campground	None	9	62
5785	Campground	None	10	62
5786	Campground	None	11	62
5787	Campground	None	12	62
5788	Campground	None	13	62
5789	Campground	None	14	62
5790	Campground	None	15	62
5791	Campground	None	16	62
5792	Campground	None	17	62
5793	Campground	None	18	62
5794	Campground	None	G1	62
5795	Campground	None	G2	62
5796	Campground	None	G3	62
5797	Campground	None	G4	62
5798	Campground	None	G5	62
5799	None	None	6	63
5800	None	None	7	63
5801	None	None	7A	63
5802	None	None	8	63
5803	None	None	9	63
5804	None	None	10	63
5805	None	None	11	63
5806	None	None	11A	63
5807	None	None	12	63
5808	None	None	13	63
5809	None	None	14	63
5810	None	None	15	63
5811	None	None	16	63
5812	None	None	17	63
5813	None	None	18	63
5814	None	None	19	63
5815	None	None	20	63
5816	None	None	21	63
5817	None	None	22	63
5818	None	None	23	63
5819	None	None	24	63
5820	None	None	25	63
5821	None	None	25A	63
5822	None	None	33	63
5823	None	None	33A	63
5824	None	None	34	63
5825	None	None	35	63
5826	None	None	35A	63
5827	None	None	36	63
5828	None	None	37	63
5829	None	None	38	63
5830	None	None	39	63
5831	None	None	40	63
5832	None	None	41	63
5833	None	None	42	63
5834	None	None	43	63
5835	None	None	43A	63
5836	None	None	N1	64
5837	None	None	N2	64
5838	None	None	N3	64
5839	None	None	N4	64
5840	None	None	N5	64
5841	None	None	N6	64
5842	None	None	N7	64
5843	None	None	N8	64
5844	None	None	N9	64
5845	None	None	N10	64
5846	None	None	N11	64
5847	None	None	N12	64
5848	None	None	N13	64
5849	None	None	N14	64
5850	None	None	N15	64
5851	None	None	N16	64
5852	None	None	N17	64
5853	None	None	N18	64
5854	None	None	N19	64
5855	None	None	N20	64
5856	None	None	N21	64
5857	None	None	N22	64
5858	None	None	N23	64
5859	None	None	N24	64
5860	None	None	N25	64
5861	None	None	N26	64
5862	None	None	N27	64
5863	None	None	N28	64
5864	None	None	N29	64
5865	None	None	N30	64
5866	None	None	N31	64
5867	None	None	N32	64
5868	None	None	N33	64
5869	None	None	N34	64
5870	None	None	N35	64
5871	None	None	N36	64
5872	None	None	N37	64
5873	None	None	N38	64
5874	None	None	N39	64
5875	None	None	N40	64
5876	None	None	N41	64
5877	None	None	N42	64
5878	None	None	N43	64
5879	None	None	N44	64
5880	None	None	N45	64
5881	None	None	N46	64
5882	None	None	N47	64
5883	None	None	N48	64
5884	None	None	N49	64
5885	None	None	N50	64
5886	None	None	N51	64
5887	None	None	N52	64
5888	None	None	N53	64
5889	None	None	N54	64
5890	None	None	N55	64
5891	None	None	N56	64
5892	None	None	N57	64
5893	None	None	N58	64
5894	None	None	N59	64
5895	None	None	N60	64
5896	None	None	N61	64
5897	None	None	N62	64
5898	None	None	N63	64
5899	None	None	N64	64
5900	None	None	N65	64
5901	None	None	N66	64
5902	None	None	N67	64
5903	None	None	N68	64
5904	None	None	N69	64
5905	None	None	N70	64
5906	None	None	N71	64
5907	None	None	N72	64
5908	None	None	N73	64
5909	None	None	N74	64
5910	None	None	N75	64
5911	None	None	N76	64
5912	None	None	N77	64
5913	None	None	N78	64
5914	None	None	N79	64
5915	None	None	N80	64
5916	None	None	N81	64
5917	Sites S1-S88	None	S1	65
5918	Sites S1-S88	None	S2	65
5919	Sites S1-S88	None	S3	65
5920	Sites S1-S88	None	S4	65
5921	Sites S1-S88	None	S5	65
5922	Sites S1-S88	None	S6	65
5923	Sites S1-S88	None	S7	65
5924	Sites S1-S88	None	S8	65
5925	Sites S1-S88	None	S9	65
5926	Sites S1-S88	None	S10	65
5927	Sites S1-S88	None	S11	65
5928	Sites S1-S88	None	S12	65
5929	Sites S1-S88	None	S13	65
5930	Sites S1-S88	None	S14	65
5931	Sites S1-S88	None	S15	65
5932	Sites S1-S88	None	S16	65
5933	Sites S1-S88	None	S17	65
5934	Sites S1-S88	None	S18	65
5935	Sites S1-S88	None	S19	65
5936	Sites S1-S88	None	S20	65
5937	Sites S1-S88	None	S21	65
5938	Sites S1-S88	None	S22	65
5939	Sites S1-S88	None	S23	65
5940	Sites S1-S88	None	S24	65
5941	Sites S1-S88	None	S25	65
5942	Sites S1-S88	None	S26	65
5943	Sites S1-S88	None	S27	65
5944	Sites S1-S88	None	S28	65
5945	Sites S1-S88	None	S29	65
5946	Sites S1-S88	None	S30	65
5947	Sites S1-S88	None	S31	65
5948	Sites S1-S88	None	S32	65
5949	Sites S1-S88	None	S33	65
5950	Sites S1-S88	None	S34	65
5951	Sites S1-S88	None	S35	65
5952	Sites S1-S88	None	S36	65
5953	Sites S1-S88	None	S37	65
5954	Sites S1-S88	None	S38	65
5955	Sites S1-S88	None	S39	65
5956	Sites S1-S88	None	S40	65
5957	Sites S1-S88	None	S41	65
5958	Sites S1-S88	None	S42	65
5959	Sites S1-S88	None	S43	65
5960	Sites S1-S88	None	S44	65
5961	Sites S1-S88	None	S45	65
5962	Sites S1-S88	None	S46	65
5963	Sites S1-S88	None	S47	65
5964	Sites S1-S88	None	S48	65
5965	Sites S1-S88	None	S49	65
5966	Sites S1-S88	None	S50	65
5967	Sites S1-S88	None	S51	65
5968	Sites S1-S88	None	S52	65
5969	Sites S1-S88	None	S53	65
5970	Sites S1-S88	None	S54	65
5971	Sites S1-S88	None	S55	65
5972	Sites S1-S88	None	S56	65
5973	Sites S1-S88	None	S57	65
5974	Sites S1-S88	None	S58	65
5975	Sites S1-S88	None	S59	65
5976	Sites S1-S88	None	S60	65
5977	Sites S1-S88	None	S61	65
5978	Sites S1-S88	None	S62	65
5979	Sites S1-S88	None	S63	65
5980	Sites S1-S88	None	S64	65
5981	Sites S1-S88	None	S65	65
5982	Sites S1-S88	None	S66	65
5983	Sites S1-S88	None	S67	65
5984	Sites S1-S88	None	S68	65
5985	Sites S1-S88	None	S69	65
5986	Sites S1-S88	None	S70	65
5987	Sites S1-S88	None	S71	65
5988	Sites S1-S88	None	S72	65
5989	Sites S1-S88	None	S73	65
5990	Sites S1-S88	None	S74	65
5991	Sites S1-S88	None	S75	65
5992	Sites S1-S88	None	S76	65
5993	Sites S1-S88	None	S77	65
5994	Sites S1-S88	None	S78	65
5995	Sites S1-S88	None	S79	65
5996	Sites S1-S88	None	S80	65
5997	Sites S1-S88	None	S81	65
5998	Sites S1-S88	None	S82	65
5999	Sites S1-S88	None	S83	65
6000	Sites S1-S88	None	S84	65
6001	Sites S1-S88	None	S85	65
6002	Sites S1-S88	None	S86	65
6003	Sites S1-S88	None	S87	65
6004	Sites S1-S88	None	S88	65
6005	None	None	1	66
6006	None	None	2	66
6007	None	None	3	66
6008	None	None	4	66
6009	None	None	5	66
6010	None	None	6	66
6011	None	None	7	66
6012	None	None	8	66
6013	None	None	9	66
6014	None	None	10	66
6015	None	None	11	66
6016	None	None	12	66
6017	None	None	13	66
6018	None	None	14	66
6019	None	None	15	66
6020	None	None	16	66
6021	None	None	17	66
6022	None	None	18	66
6023	None	None	19	66
6024	None	None	20	66
6025	None	None	21	66
6026	None	None	22	66
6027	None	None	23	66
6028	None	None	24	66
6029	None	None	25	66
6030	None	None	26	66
6031	None	None	27	66
6032	None	None	28	66
6033	None	None	29	66
6034	None	None	30	66
6035	None	None	31	66
6036	None	None	32	66
6037	None	None	33	66
6038	None	None	34	66
6039	None	None	35	66
6040	None	None	36	66
6041	None	None	37	66
6042	None	None	38	66
6043	None	None	39	66
6044	None	None	40	66
6045	None	None	41	66
6046	None	None	42	66
6047	None	None	43	66
6048	None	None	44	66
6049	None	None	45	66
6050	None	None	1	67
6051	None	None	2	67
6052	None	None	8	67
6053	None	None	9	67
6054	None	None	10	67
6055	None	None	11	67
6056	None	None	12	67
6057	None	None	13	67
6058	None	None	14	67
6059	None	None	15	67
6060	None	None	27	67
6061	None	None	28	67
6062	None	None	29	67
6063	None	None	27	67
6064	None	None	28	67
6065	None	None	29	67
6066	Sites 1-90	None	31	68
6067	Sites 1-90	None	32	68
6068	Sites 1-90	None	33	68
6069	Sites 1-90	None	34	68
6070	Sites 1-90	None	48	68
6071	Sites 1-90	None	49	68
6072	Sites 1-90	None	50	68
6073	Sites 1-90	None	51	68
6074	Sites 1-90	None	52	68
6075	Sites 1-90	None	53	68
6076	Sites 1-90	None	54	68
6077	Sites 1-90	None	55	68
6078	Sites 1-90	None	56	68
6079	Sites 1-90	None	57	68
6080	Sites 1-90	None	58	68
6081	Sites 1-90	None	59	68
6082	Sites 1-90	None	60	68
6083	Sites 1-90	None	61	68
6084	Sites 1-90	None	62	68
6085	Sites 1-90	None	63	68
6086	Sites 1-90	None	64	68
6087	Sites 1-90	None	65	68
6088	Sites 1-90	None	66	68
6089	Sites 1-90	None	67	68
6090	Sites 1-90	None	68	68
6091	Sites 1-90	None	69	68
6092	Sites 1-90	None	70	68
6093	Sites 1-90	None	71	68
6094	Sites 1-90	None	72	68
6095	Sites 1-90	None	73	68
6096	Sites 1-90	None	74	68
6097	Sites 1-90	None	75	68
6098	Sites 1-90	None	76	68
6099	Sites 1-90	None	77	68
6100	Sites 1-90	None	78	68
6101	Sites 1-90	None	79	68
6102	Sites 1-90	None	80	68
6103	Sites 1-90	None	81	68
6104	Sites 1-90	None	82	68
6105	Sites 1-90	None	83	68
6106	Sites 1-90	None	84	68
6107	Sites 1-90	None	85	68
6108	Sites 1-90	None	86	68
6109	Sites 1-90	None	87	68
6110	Sites 1-90	None	88	68
6111	Sites 1-90	None	89	68
6112	Sites 1-90	None	90	68
6113	Campground	None	1	69
6114	Campground	None	2	69
6115	Campground	None	3	69
6116	Campground	None	4	69
6117	Campground	None	5	69
6118	Campground	None	6	69
6119	Campground	None	7	69
6120	Campground	None	8	69
6121	Campground	None	9	69
6122	Campground	None	10	69
6123	Campground	None	11	69
6124	Campground	None	12	69
6125	Campground	None	13	69
6126	Campground	None	14	69
6127	Campground	None	15	69
6128	Campground	None	16	69
6129	Campground	None	17	69
6130	Campground	None	18	69
6131	Campground	None	19	69
6132	Campground	None	20	69
6133	Campground	None	21	69
6134	Campground	None	22	69
6135	Campground	None	23	69
6136	Campground	None	24	69
6137	Campground	None	25	69
6138	Campground	None	26	69
6139	Campground	None	27	69
6140	Campground	None	28	69
6141	Campground	None	29	69
6142	Campground	None	30	69
6143	Campground	None	31	69
6144	Campground	None	32	69
6145	Campground	None	33	69
6146	Campground	None	34	69
6147	Campground	None	37	69
6148	Campground	None	38	69
6149	Campground	None	39	69
6150	Campground	None	40	69
6151	Campground	None	41	69
6152	Campground	None	42	69
6153	Campground	None	43	69
6154	Campground	None	44	69
6155	Campground	None	45	69
6156	Campground	None	46	69
6157	Campground	None	47	69
6158	Campground	None	48	69
6159	Campground	None	49	69
6160	Campground	None	50	69
6161	Campground	None	51	69
6162	Campground	None	52	69
6163	Campground	None	53	69
6164	Campground	None	54	69
6165	Campground	None	55	69
6166	Campground	None	56	69
6167	Campground	None	57	69
6168	Campground	None	58	69
6169	Campground	None	59	69
6170	Campground	None	60	69
6171	Campground	None	61	69
6172	Campground	None	62	69
6173	Campground	None	63	69
6174	Campground	None	64	69
6175	Campground	None	65	69
6176	Campground	None	66	69
6177	Campground	None	67	69
6178	Campground	None	68	69
6179	Campground	None	69	69
6180	Campground	None	70	69
6181	Campground	None	71	69
6182	Campground	None	82	69
6183	Campground	None	83	69
6184	Campground	None	84	69
6185	Group and Picnic	None	G1	69
6186	A (Sites 1-37)	None	1	70
6187	A (Sites 1-37)	None	2	70
6188	A (Sites 1-37)	None	3	70
6189	A (Sites 1-37)	None	4	70
6190	A (Sites 1-37)	None	5	70
6191	A (Sites 1-37)	None	6	70
6192	A (Sites 1-37)	None	7	70
6193	A (Sites 1-37)	None	8	70
6194	A (Sites 1-37)	None	9	70
6195	A (Sites 1-37)	None	10	70
6196	A (Sites 1-37)	None	11	70
6197	A (Sites 1-37)	None	12	70
6198	A (Sites 1-37)	None	13	70
6199	A (Sites 1-37)	None	14	70
6200	A (Sites 1-37)	None	15	70
6201	A (Sites 1-37)	None	16	70
6202	A (Sites 1-37)	None	17	70
6203	A (Sites 1-37)	None	18	70
6204	A (Sites 1-37)	None	19	70
6205	A (Sites 1-37)	None	20	70
6206	A (Sites 1-37)	None	21	70
6207	A (Sites 1-37)	None	22	70
6208	A (Sites 1-37)	None	23	70
6209	A (Sites 1-37)	None	24	70
6210	A (Sites 1-37)	None	25	70
6211	A (Sites 1-37)	None	26	70
6212	A (Sites 1-37)	None	27	70
6213	A (Sites 1-37)	None	28	70
6214	A (Sites 1-37)	None	29	70
6215	A (Sites 1-37)	None	30	70
6216	A (Sites 1-37)	None	31	70
6217	A (Sites 1-37)	None	32	70
6218	A (Sites 1-37)	None	33	70
6219	A (Sites 1-37)	None	34	70
6220	A (Sites 1-37)	None	35	70
6221	A (Sites 1-37)	None	36	70
6222	A (Sites 1-37)	None	37	70
6223	B (Sites 38-44)	None	38	70
6224	B (Sites 38-44)	None	39	70
6225	B (Sites 38-44)	None	40	70
6226	B (Sites 38-44)	None	41	70
6227	B (Sites 38-44)	None	42	70
6228	B (Sites 38-44)	None	43	70
6229	B (Sites 38-44)	None	44	70
6230	WalkIn (W1-W16)	None	W1	70
6231	WalkIn (W1-W16)	None	W2	70
6232	WalkIn (W1-W16)	None	W3	70
6233	WalkIn (W1-W16)	None	W4	70
6234	WalkIn (W1-W16)	None	W5	70
6235	WalkIn (W1-W16)	None	W6	70
6236	WalkIn (W1-W16)	None	W7	70
6237	WalkIn (W1-W16)	None	W8	70
6238	WalkIn (W1-W16)	None	W9	70
6239	WalkIn (W1-W16)	None	W10	70
6240	WalkIn (W1-W16)	None	W11	70
6241	WalkIn (W1-W16)	None	W12	70
6242	WalkIn (W1-W16)	None	W13	70
6243	WalkIn (W1-W16)	None	W14	70
6244	WalkIn (W1-W16)	None	W15	70
6245	WalkIn (W1-W16)	None	W16	70
6246	A (Sites 1-41)	None	1	71
6247	A (Sites 1-41)	None	1A	71
6248	A (Sites 1-41)	None	2	71
6249	A (Sites 1-41)	None	2A	71
6250	A (Sites 1-41)	None	3	71
6251	A (Sites 1-41)	None	4	71
6252	A (Sites 1-41)	None	13	71
6253	A (Sites 1-41)	None	14	71
6254	A (Sites 1-41)	None	15	71
6255	A (Sites 1-41)	None	16	71
6256	A (Sites 1-41)	None	17	71
6257	A (Sites 1-41)	None	18	71
6258	A (Sites 1-41)	None	19	71
6259	A (Sites 1-41)	None	20	71
6260	A (Sites 1-41)	None	21	71
6261	A (Sites 1-41)	None	22	71
6262	A (Sites 1-41)	None	23	71
6263	A (Sites 1-41)	None	24	71
6264	A (Sites 1-41)	None	25	71
6265	A (Sites 1-41)	None	26	71
6266	A (Sites 1-41)	None	27	71
6267	A (Sites 1-41)	None	28	71
6268	A (Sites 1-41)	None	29	71
6269	A (Sites 1-41)	None	30	71
6270	A (Sites 1-41)	None	31	71
6271	A (Sites 1-41)	None	32	71
6272	A (Sites 1-41)	None	33	71
6273	Sites 1-24	None	15	72
6274	Sites 1-24	None	16	72
6275	Sites 1-24	None	17	72
6276	Sites 1-24	None	18	72
6277	Sites 1-24	None	19	72
6278	Sites 1-24	None	20	72
6279	Sites 1-24	None	21	72
6280	Sites 1-24	None	22	72
6281	Sites 1-24	None	23	72
6282	Sites 1-24	None	24	72
6283	Campground	None	10	73
6284	Campground	None	39	73
6285	Campground	None	40	73
6286	Campground	None	41	73
6287	Campground	None	42	73
6288	Campground	None	43	73
6289	Campground	None	44	73
6290	Campground	None	45	73
6291	Campground	None	46	73
6292	Campground	None	47	73
6293	Campground	None	48	73
6294	Campground	None	49	73
6295	Campground	None	50	73
6296	Campground	None	51	73
6297	Campground	None	52	73
6298	Campground	None	53	73
6299	Campground	None	54	73
6300	Campground	None	55	73
6301	Campground	None	56	73
6302	Campground	None	57	73
6303	Campground	None	58	73
6304	Campground	None	59	73
6305	Campground	None	60	73
6306	Campground	None	61	73
6307	Campground	None	62	73
6308	Campground	None	63	73
6309	Campground	None	64	73
6310	Campground	None	65	73
6311	Campground	None	66	73
6312	Campground	None	67	73
6313	Campground	None	68	73
6314	Campground	None	69	73
6315	Campground	None	70	73
6316	Campground	None	71	73
6317	Campground	None	72	73
6318	Campground	None	73	73
6319	Campground	None	74	73
6320	Campground	None	75	73
6321	Campground	None	76	73
6322	Campground	None	77	73
6323	Campground	None	78	73
6324	Campground	None	2	74
6325	Campground	None	3	74
6326	Campground	None	4	74
6327	Campground	None	5	74
6328	Campground	None	6	74
6329	Campground	None	7	74
6330	Campground	None	8	74
6331	Campground	None	9	74
6332	Campground	None	10	74
6333	Campground	None	11	74
6334	Campground	None	12	74
6335	Campground	None	13	74
6336	Campground	None	14	74
6337	Campground	None	15	74
6338	Campground	None	16	74
6339	Campground	None	17	74
6340	Campground	None	18	74
6341	Campground	None	19	74
6342	Campground	None	20	74
6343	Campground	None	21	74
6344	Campground	None	22	74
6345	Campground	None	23	74
6346	Campground	None	24	74
6347	Campground	None	25	74
6348	Campground	None	26	74
6349	Campground	None	27	74
6350	Campground	None	28	74
6351	Campground	None	29	74
6352	Campground	None	30	74
6353	Campground	None	31	74
6354	Campground	None	32	74
6355	Campground	None	33	74
6356	Campground	None	34	74
6357	Campground	None	35	74
6358	Campground	None	36	74
6359	Campground	None	37	74
6360	Campground	None	38	74
6361	Campground	None	39	74
6362	Campground	None	40	74
6363	Campground	None	41	74
6364	Campground	None	42	74
6365	Campground	None	43	74
6366	Campground	None	44	74
6367	Campground	None	45	74
6368	Campground	None	46	74
6369	Campground	None	47	74
6370	Campground	None	48	74
6371	Campground	None	49	74
6372	Campground	None	50	74
6373	Campground	None	51	74
6374	Campground	None	52	74
6375	Campground	None	53	74
6376	Campground	None	54	74
6377	Campground	None	55	74
6378	Campground	None	56	74
6379	Campground	None	57	74
6380	Campground	None	58	74
6381	Campground	None	59	74
6382	Campground	None	60	74
6383	Campground	None	61	74
6384	Campground	None	62	74
6385	Campground	None	63	74
6386	Campground	None	64	74
6387	Campground	None	65	74
6388	Campground	None	66	74
6389	Campground	None	67	74
6390	Campground	None	68	74
6391	Campground	None	69	74
6392	Campground	None	70	74
6393	Campground	None	71	74
6394	Campground	None	72	74
6395	Campground	None	73	74
6396	Campground	None	74	74
6397	Campground	None	75	74
6398	Campground	None	76	74
6399	Campground	None	77	74
6400	Campground	None	78	74
6401	Campground	None	79	74
6402	Campground	None	80	74
6403	Campground	None	81	74
6404	Campground	None	82	74
6405	Campground	None	83	74
6406	Campground	None	84	74
6407	Campground	None	85	74
6408	Campground	None	86	74
6409	Campground	None	87	74
6410	Campground	None	88	74
6411	Campground	None	89	74
6412	Campground	None	90	74
6413	Campground	None	91	74
6414	Campground	None	92	74
6415	Campground	None	93	74
6416	Campground	None	94	74
6417	Campground	None	95	74
6418	Campground	None	96	74
6419	Campground	None	97	74
6420	Campground	None	98	74
6421	Campground	None	99	74
6422	Campground	None	100	74
6423	Campground	None	101	74
6424	Campground	None	102	74
6425	Campground	None	103	74
6426	Campground	None	104	74
6427	Campground	None	105	74
6428	Campground	None	106	74
6429	Campground	None	107	74
6430	Campground	None	108	74
6431	Campground	None	109	74
6432	Campground	None	110	74
6433	Campground	None	111	74
6434	Campground	None	112	74
6435	Campground	None	113	74
6436	Campground	None	114	74
6437	Campground	None	115	74
6438	Campground	None	116	74
6439	Campground	None	117	74
6440	Campground	None	118	74
6441	Campground	None	119	74
6442	Campground	None	120	74
6443	Campground	None	121	74
6444	Campground	None	122	74
6445	Campground	None	123	74
6446	Campground	None	124	74
6447	Campground	None	125	74
6448	Campground	None	126	74
6449	Campground	None	127	74
6450	Campground	None	128	74
6451	Campground	None	129	74
6452	Campground	None	130	74
6453	Campground	None	131	74
6454	Campground	None	132	74
6455	Campground	None	133	74
6456	Campground	None	134	74
6457	Campground	None	135	74
6458	Campground	None	136	74
6459	Campground	None	137	74
6460	Campground	None	138	74
6461	Campground	None	139	74
6462	Campground	None	140	74
6463	Campground	None	141	74
6464	Campground	None	142	74
6465	Campground	None	143	74
6466	Campground	None	144	74
6467	Campground	None	145	74
6468	Campground	None	146	74
6469	Campground	None	147	74
6470	Campground	None	148	74
6471	Campground	None	149	74
6472	Campground	None	150	74
6473	Campground	None	151	74
6474	Campground	None	152	74
6475	Campground	None	153	74
6476	Campground	None	154	74
6477	Campground	None	155	74
6478	Campground	None	156	74
6479	Campground	None	157	74
6480	Campground	None	158	74
6481	Campground	None	159	74
6482	Campground	None	160	74
6483	Campground	None	161	74
6484	Campground	None	162	74
6485	Campground	None	163	74
6486	Campground	None	164	74
6487	Campground	None	165	74
6488	Campground	None	166	74
6489	Campground	None	167	74
6490	Campground	None	168	74
6491	Campground	None	169	74
6492	Campground	None	170	74
6493	Campground	None	171	74
6494	Campground	None	172	74
6495	Campground	None	173	74
6496	Group Sites & Picnic Shelters	None	174	74
6497	Walk-in	None	T1	74
6498	Walk-in	None	T2	74
6499	Walk-in	None	T3	74
6500	Walk-in	None	T4	74
6501	Walk-in	None	T5	74
6502	Walk-in	None	T6	74
6503	Walk-in	None	T7	74
6504	Walk-in	None	T8	74
6505	Walk-in	None	T9	74
6506	Walk-in	None	T10	74
6507	Walk-in	None	T11	74
6508	Walk-in	None	T12	74
6509	Walk-in	None	T13	74
6510	Walk-in	None	T14	74
6511	Walk-in	None	T15	74
6512	Walk-in	None	T16	74
6513	Walk-in	None	T17	74
6514	Walk-in	None	T18	74
6515	Walk-in	None	T19	74
6516	Walk-in	None	T20	74
6517	Walk-in	None	T21	74
6518	Walk-in	None	T22	74
6519	Walk-in	None	T23	74
6520	Walk-in	None	T24	74
6521	Walk-in	None	T25	74
6522	Sites 175 - 226	None	175	74
6523	Sites 175 - 226	None	176	74
6524	Sites 175 - 226	None	177	74
6525	Sites 175 - 226	None	178	74
6526	Sites 175 - 226	None	179	74
6527	Sites 175 - 226	None	180	74
6528	Sites 175 - 226	None	181	74
6529	Sites 175 - 226	None	182	74
6530	Sites 175 - 226	None	183	74
6531	Sites 175 - 226	None	184	74
6532	Sites 175 - 226	None	185	74
6533	Sites 175 - 226	None	186	74
6534	Sites 175 - 226	None	187	74
6535	Sites 175 - 226	None	188	74
6536	Sites 175 - 226	None	189	74
6537	Sites 175 - 226	None	190	74
6538	Sites 175 - 226	None	191	74
6539	Sites 175 - 226	None	192	74
6540	Sites 175 - 226	None	193	74
6541	Sites 175 - 226	None	194	74
6542	Sites 175 - 226	None	195	74
6543	Sites 175 - 226	None	196	74
6544	Sites 175 - 226	None	197	74
6545	Sites 175 - 226	None	198	74
6546	Sites 175 - 226	None	199	74
6547	Sites 175 - 226	None	200	74
6548	Sites 175 - 226	None	201	74
6549	Sites 175 - 226	None	202	74
6550	Sites 175 - 226	None	203	74
6551	Sites 175 - 226	None	204	74
6552	Sites 175 - 226	None	205	74
6553	Sites 175 - 226	None	206	74
6554	Sites 175 - 226	None	207	74
6555	Sites 175 - 226	None	208	74
6556	Sites 175 - 226	None	209	74
6557	Sites 175 - 226	None	210	74
6558	Sites 175 - 226	None	211	74
6559	Sites 175 - 226	None	212	74
6560	Sites 175 - 226	None	213	74
6561	Sites 175 - 226	None	214	74
6562	Sites 175 - 226	None	215	74
6563	Sites 175 - 226	None	216	74
6564	Sites 175 - 226	None	217	74
6565	Sites 175 - 226	None	218	74
6566	Sites 175 - 226	None	219	74
6567	Sites 175 - 226	None	220	74
6568	Sites 175 - 226	None	221	74
6569	Sites 175 - 226	None	222	74
6570	Sites 175 - 226	None	223	74
6571	Sites 175 - 226	None	224	74
6572	Sites 175 - 226	None	225	74
6573	Sites 175 - 226	None	226	74
6574	Group Sites & Picnic Shelters	None	G1	74
6575	Group Sites & Picnic Shelters	None	G2	74
6576	Group Sites & Picnic Shelters	None	G3	74
6577	Group Sites & Picnic Shelters	None	G4	74
6578	None	None	1	75
6579	None	None	2	75
6580	None	None	3	75
6581	None	None	4	75
6582	None	None	5	75
6583	None	None	6	75
6584	None	None	7	75
6585	None	None	8	75
6586	None	None	9	75
6587	None	None	10	75
6588	None	None	11	75
6589	None	None	12	75
6590	None	None	13	75
6591	None	None	14	75
6592	None	None	15	75
6593	None	None	16	75
6594	None	None	17	75
6595	None	None	18	75
6596	None	None	19	75
6597	None	None	20	75
6598	None	None	21	75
6599	None	None	22	75
6600	None	None	23	75
6601	None	None	24	75
6602	None	None	25	75
6603	None	None	26	75
6604	None	None	27	75
6605	Campground	None	3	76
6606	Campground	None	4	76
6607	Campground	None	5	76
6608	Campground	None	6	76
6609	Campground	None	7	76
6610	Campground	None	8	76
6611	Campground	None	9	76
6612	Campground	None	10	76
6613	Campground	None	11	76
6614	Campground	None	12	76
6615	Campground	None	13	76
6616	Campground	None	14	76
6617	Campground	None	15	76
6618	Campground	None	16	76
6619	Campground	None	17	76
6620	Campground	None	18	76
6621	Campground	None	19	76
6622	Campground	None	20	76
6623	Campground	None	21	76
6624	Campground	None	22	76
6625	Campground	None	23	76
6626	Campground	None	24	76
6627	Campground	None	25	76
6628	Campground	None	26	76
6629	Campground	None	27	76
6630	Campground	None	28	76
6631	Campground	None	29	76
6632	Campground	None	30	76
6633	Campground	None	31	76
6634	Campground	None	32	76
6635	Campground	None	33	76
6636	Campground	None	34	76
6637	Campground	None	35	76
6638	Campground	None	36	76
6639	Campground	None	37	76
6640	Campground	None	38	76
6641	Campground	None	39	76
6642	Campground	None	40	76
6643	Campground	None	41	76
6644	Campground	None	42	76
6645	Campground	None	43	76
6646	Campground	None	44	76
6647	Campground	None	45	76
6648	Campground	None	46	76
6649	Campground	None	47	76
6650	Campground	None	48	76
6651	Campground	None	49	76
6652	Campground	None	50	76
6653	Campground	None	51	76
6654	Campground	None	52	76
6655	Campground	None	53	76
6656	Campground	None	54	76
6657	Campground	None	55	76
6658	Campground	None	56	76
6659	Campground	None	57	76
6660	Campground	None	58	76
6661	Campground	None	59	76
6662	Campground	None	60	76
6663	Campground	None	61	76
6664	Campground	None	62	76
6665	Campground	None	63	76
6666	Campground	None	64	76
6667	Campground	None	65	76
6668	Sites 1-33	None	11	77
6669	Sites 1-33	None	12	77
6670	Sites 1-33	None	13	77
6671	Sites 1-33	None	14	77
6672	Sites 1-33	None	15	77
6673	Sites 1-33	None	16	77
6674	Sites 1-33	None	17	77
6675	Sites 1-33	None	18	77
6676	Sites 1-33	None	19	77
6677	Sites 1-14, G1-G3	None	1	78
6678	Sites 1-14, G1-G3	None	2	78
6679	Sites 1-14, G1-G3	None	3	78
6680	Sites 1-14, G1-G3	None	6	78
6681	Sites 1-14, G1-G3	None	7	78
6682	Sites 15-20	None	16	78
6683	Sites 15-20	None	17	78
6684	Sites 15-20	None	18	78
6685	Sites 15-20	None	19	78
6686	Sites 15-20	None	20	78
6687	Campground	None	1	79
6688	Campground	None	2	79
6689	Campground	None	3	79
6690	Campground	None	4	79
6691	Campground	None	5	79
6692	Campground	None	6	79
6693	Campground	None	7	79
6694	Campground	None	8	79
6695	Campground	None	9	79
6696	Campground	None	10	79
6697	Campground	None	11	79
6698	Campground	None	12	79
6699	Campground	None	13	79
6700	Campground	None	14	79
6701	Campground	None	15	79
6702	Campground	None	32	79
6703	Campground	None	33	79
6704	Campground	None	34	79
6705	Campground	None	35	79
6706	Campground	None	36	79
6707	Campground	None	37	79
6708	Hicks Campground	None	H1	80
6709	Hicks Campground	None	H2	80
6710	Hicks Campground	None	H3	80
6711	Hicks Campground	None	H4	80
6712	Hicks Campground	None	H5	80
6713	Hicks Campground	None	H6	80
6714	Hicks Campground	None	H7	80
6715	Hicks Campground	None	H8	80
6716	Hicks Campground	None	H9	80
6717	Hicks Campground	None	H10	80
6718	Hicks Campground	None	H11	80
6719	Hicks Campground	None	H12	80
6720	Hicks Campground	None	H13	80
6721	Hicks Campground	None	H14	80
6722	Hicks Campground	None	H15	80
6723	Hicks Campground	None	H16	80
6724	Hicks Campground	None	H17	80
6725	Hicks Campground	None	H25	80
6726	Hicks Campground	None	H26	80
6727	Hicks Campground	None	H27	80
6728	Hicks Campground	None	H28	80
6729	Hicks Campground	None	H29	80
6730	Hicks Campground	None	H30	80
6731	Hicks Campground	None	H31	80
6732	Hicks Campground	None	H32	80
6733	Hicks Campground	None	H33	80
6734	Hicks Campground	None	H34	80
6735	Hicks Campground	None	H35	80
6736	Hicks Campground	None	H36	80
6737	Hicks Campground	None	H37	80
6738	Hicks Campground	None	H38	80
6739	Hicks Campground	None	H39	80
6740	Hicks Campground	None	H40	80
6741	Hicks Campground	None	H41	80
6742	Hicks Campground	None	H42	80
6743	Hicks Campground	None	H43	80
6744	Hicks Campground	None	H44	80
6745	Hicks Campground	None	H45	80
6746	Hicks Campground	None	H46	80
6747	Hicks Campground	None	H47	80
6748	Hicks Campground	None	H48	80
6749	Hicks Campground	None	H49	80
6750	Hicks Campground	None	H50	80
6751	Hicks Campground	None	H51	80
6752	Hicks Campground	None	H52	80
6753	Hicks Campground	None	H53	80
6754	Hicks Campground	None	H54	80
6755	Hicks Campground	None	H55	80
6756	Hicks Campground	None	H56	80
6757	Hicks Campground	None	H57	80
6758	Hicks Campground	None	H58	80
6759	Hicks Campground	None	H59	80
6760	Hicks Campground	None	H60	80
6761	Hicks Campground	None	H61	80
6762	Hicks Campground	None	H62	80
6763	Hicks Campground	None	H63	80
6764	Hicks Campground	None	H64	80
6765	Hicks Campground	None	H65	80
6766	Hicks Campground	None	H66	80
6767	Hicks Campground	None	H67	80
6768	Hicks Campground	None	H68	80
6769	Hicks Campground	None	H69	80
6770	Hicks Campground	None	H70	80
6771	Bench Campground	None	B1	80
6772	Bench Campground	None	B2	80
6773	Bench Campground	None	B3	80
6774	Bench Campground	None	B4	80
6775	Bench Campground	None	B5	80
6776	Bench Campground	None	B6	80
6777	Bench Campground	None	B7	80
6778	Bench Campground	None	B8	80
6779	Bench Campground	None	B9	80
6780	Bench Campground	None	B10	80
6781	Bench Campground	None	B11	80
6782	Bench Campground	None	B12	80
6783	Bench Campground	None	B13	80
6784	Bench Campground	None	B14	80
6785	Bench Campground	None	B15	80
6786	Bench Campground	None	B16	80
6787	Bench Campground	None	B17	80
6788	Bench Campground	None	B18	80
6789	Bench Campground	None	B19	80
6790	Bench Campground	None	B20	80
6791	Bench Campground	None	B21	80
6792	Bench Campground	None	B22	80
6793	Bench Campground	None	B23	80
6794	Bench Campground	None	B24	80
6795	Bench Campground	None	B26	80
6796	Bench Campground	None	B27	80
6797	Bench Campground	None	B28	80
6798	Bench Campground	None	B29	80
6799	Bench Campground	None	B30	80
6800	Bench Campground	None	B31	80
6801	Bench Campground	None	B32	80
6802	Bench Campground	None	B26	80
6803	Bench Campground	None	B27	80
6804	Bench Campground	None	B28	80
6805	Bench Campground	None	B29	80
6806	Bench Campground	None	B30	80
6807	Bench Campground	None	B31	80
6808	Bench Campground	None	B32	80
6809	Bench Campground	None	B34	80
6810	Bench Campground	None	B35	80
6811	Bench Campground	None	B36	80
6812	Bench Campground	None	B37	80
6813	Bench Campground	None	B38	80
6814	Bench Campground	None	B39	80
6815	Bench Campground	None	B40	80
6816	Bench Campground	None	B41	80
6817	Bench Campground	None	B42	80
6818	Bench Campground	None	B43	80
6819	Bench Campground	None	B44	80
6820	Bench Campground	None	B45	80
6821	Bench Campground	None	B46	80
6822	Bench Campground	None	B47	80
6823	Bench Campground	None	B48	80
6824	Bench Campground	None	B49	80
6825	Bench Campground	None	B50	80
6826	Bench Campground	None	B51	80
6827	Bench Campground	None	B52	80
6828	Bench Campground	None	B53	80
6829	Bench Campground	None	B54	80
6830	Bench Campground	None	B55	80
6831	Bench Campground	None	B56	80
6832	Bench Campground	None	B57	80
6833	Bench Campground	None	B58	80
6834	Bench Campground	None	B59	80
6835	Bench Campground	None	B60	80
6836	Bench Campground	None	B61	80
6837	Bench Campground	None	B62	80
6838	Bench Campground	None	B63	80
6839	Bench Campground	None	B64	80
6840	Lakeside Campground	None	L1	80
6841	Lakeside Campground	None	L2	80
6842	Lakeside Campground	None	L3	80
6843	Lakeside Campground	None	L4	80
6844	Lakeside Campground	None	L5	80
6845	Lakeside Campground	None	L6	80
6846	Lakeside Campground	None	L7	80
6847	Lakeside Campground	None	L8	80
6848	Lakeside Campground	None	L9	80
6849	Lakeside Campground	None	L10	80
6850	Lakeside Campground	None	L11	80
6851	Lakeside Campground	None	L12	80
6852	Lakeside Campground	None	L13	80
6853	Lakeside Campground	None	L14	80
6854	Lakeside Campground	None	L15	80
6855	Lakeside Campground	None	L16	80
6856	Lakeside Campground	None	L17	80
6857	Lakeside Campground	None	L18	80
6858	Lakeside Campground	None	L19	80
6859	Lakeside Campground	None	L20	80
6860	Lakeside Campground	None	L21	80
6861	Lakeside Campground	None	L22	80
6862	Lakeside Campground	None	L23	80
6863	Lakeside Campground	None	L24	80
6864	Lakeside Campground	None	L25	80
6865	Lakeside Campground	None	L26	80
6866	Lakeside Campground	None	L27	80
6867	Lakeside Campground	None	L28	80
6868	Lakeside Campground	None	L29	80
6869	Lakeside Campground	None	L30	80
6870	Lakeside Campground	None	L31	80
6871	Lakeside Campground	None	L32	80
6872	Lakeside Campground	None	L33	80
6873	Lakeside Campground	None	L34	80
6874	Lakeside Campground	None	L35	80
6875	Lakeside Campground	None	L36	80
6876	Lakeside Campground	None	L37	80
6877	Lakeside Campground	None	L38	80
6878	Lakeside Campground	None	L39	80
6879	Lakeside Campground	None	L40	80
6880	Lakeside Campground	None	L41	80
6881	Lakeside Campground	None	L42	80
6882	Group Site	None	G1-Hicks Lake Group	80
6883	Buttle Lake Campground	None	1	81
6884	Buttle Lake Campground	None	2	81
6885	Buttle Lake Campground	None	3	81
6886	Buttle Lake Campground	None	4	81
6887	Buttle Lake Campground	None	5	81
6888	Buttle Lake Campground	None	6	81
6889	Buttle Lake Campground	None	7	81
6890	Buttle Lake Campground	None	8	81
6891	Buttle Lake Campground	None	9	81
6892	Buttle Lake Campground	None	10	81
6893	Buttle Lake Campground	None	11	81
6894	Buttle Lake Campground	None	12	81
6895	Buttle Lake Campground	None	13	81
6896	Buttle Lake Campground	None	14	81
6897	Buttle Lake Campground	None	15	81
6898	Buttle Lake Campground	None	16	81
6899	Buttle Lake Campground	None	17	81
6900	Buttle Lake Campground	None	18	81
6901	Buttle Lake Campground	None	19	81
6902	Buttle Lake Campground	None	20	81
6903	Buttle Lake Campground	None	21	81
6904	Buttle Lake Campground	None	22	81
6905	Buttle Lake Campground	None	23	81
6906	Buttle Lake Campground	None	24	81
6907	Buttle Lake Campground	None	25	81
6908	Buttle Lake Campground	None	26	81
6909	Buttle Lake Campground	None	27	81
6910	Buttle Lake Campground	None	28	81
6911	Buttle Lake Campground	None	29	81
6912	Buttle Lake Campground	None	30	81
6913	Buttle Lake Campground	None	31	81
6914	Buttle Lake Campground	None	32	81
6915	Buttle Lake Campground	None	33	81
6916	Buttle Lake Campground	None	34	81
6917	Buttle Lake Campground	None	35	81
6918	Buttle Lake Campground	None	36	81
6919	Buttle Lake Campground	None	37	81
6920	Buttle Lake Campground	None	38	81
6921	Buttle Lake Campground	None	39	81
6922	Buttle Lake Campground	None	40	81
6923	Buttle Lake Campground	None	41	81
6924	Buttle Lake Campground	None	42	81
6925	Buttle Lake Campground	None	43	81
6926	Buttle Lake Campground	None	44	81
6927	Buttle Lake Campground	None	45	81
6928	Buttle Lake Campground	None	46	81
6929	Buttle Lake Campground	None	47	81
6930	Buttle Lake Campground	None	48	81
6931	Buttle Lake Campground	None	49	81
6932	Buttle Lake Campground	None	50	81
6933	Buttle Lake Campground	None	51	81
6934	Buttle Lake Campground	None	52	81
6935	Buttle Lake Campground	None	53	81
6936	Buttle Lake Campground	None	54	81
6937	Buttle Lake Campground	None	55	81
6938	Buttle Lake Campground	None	56	81
6939	Buttle Lake Campground	None	57	81
6940	Buttle Lake Campground	None	58	81
6941	Buttle Lake Campground	None	59	81
6942	Buttle Lake Campground	None	60	81
6943	Buttle Lake Campground	None	61	81
6944	Buttle Lake Campground	None	62	81
6945	Buttle Lake Campground	None	63	81
6946	Buttle Lake Campground	None	64	81
6947	Buttle Lake Campground	None	65	81
6948	Buttle Lake Campground	None	66	81
6949	Buttle Lake Campground	None	67	81
6950	Buttle Lake Campground	None	68	81
6951	Buttle Lake Campground	None	69	81
6952	Buttle Lake Campground	None	70	81
6953	Buttle Lake Campground	None	71	81
6954	Buttle Lake Campground	None	72	81
6955	Buttle Lake Campground	None	73	81
6956	Buttle Lake Campground	None	74	81
6957	Buttle Lake Campground	None	75	81
6958	Buttle Lake Campground	None	76	81
6959	Buttle Lake Campground	None	77	81
6960	Buttle Lake Campground	None	78	81
6961	Buttle Lake Campground	None	79	81
6962	Buttle Lake Campground	None	80	81
6963	Buttle Lake Campground	None	81	81
6964	Buttle Lake Campground	None	82	81
6965	Buttle Lake Campground	None	83	81
6966	Buttle Lake Campground	None	84	81
6967	Buttle Lake Campground	None	85	81
6968	Buttle Lake Campground	None	86	81
6969	Sites 1-135	None	87	81
6970	Sites 1-135	None	88	81
6971	Sites 1-135	None	89	81
6972	Sites 1-135	None	90	81
6973	Sites 1-135	None	91	81
6974	Sites 1-135	None	92	81
6975	Sites 1-135	None	93	81
6976	Sites 1-135	None	94	81
6977	Sites 1-135	None	95	81
6978	Sites 1-135	None	96	81
6979	Sites 1-135	None	97	81
6980	Sites 1-135	None	98	81
6981	Sites 1-135	None	99	81
6982	Sites 1-135	None	100	81
6983	Sites 1-135	None	101	81
6984	Sites 1-135	None	102	81
6985	Sites 1-135	None	103	81
6986	Sites 1-135	None	104	81
6987	Sites 1-135	None	105	81
6988	Sites 1-135	None	106	81
6989	Sites 1-135	None	107	81
6990	Sites 1-135	None	108	81
6991	Sites 1-135	None	109	81
6992	Sites 1-135	None	110	81
6993	Sites 1-135	None	111	81
6994	Sites 1-135	None	112	81
6995	Sites 1-135	None	113	81
6996	Sites 1-135	None	114	81
6997	Sites 1-135	None	115	81
6998	Sites 1-135	None	116	81
6999	Sites 1-135	None	117	81
7000	Sites 1-135	None	118	81
7001	Sites 1-135	None	119	81
7002	Sites 1-135	None	120	81
7003	Sites 1-135	None	121	81
7004	Sites 1-135	None	122	81
7005	Sites 1-135	None	123	81
7006	Sites 1-135	None	124	81
7007	Sites 1-135	None	125	81
7008	Sites 1-135	None	126	81
7009	Sites 1-135	None	127	81
7010	Sites 1-135	None	128	81
7011	Sites 1-135	None	129	81
7012	Sites 1-135	None	130	81
7013	Sites 1-135	None	131	81
7014	Sites 1-135	None	132	81
7015	Sites 1-135	None	133	81
7016	Sites 1-135	None	134	81
7017	Sites 1-135	None	135	81
7018	Sites 136-330, G1	None	136	81
7019	Sites 136-330, G1	None	137	81
7020	Sites 136-330, G1	None	138	81
7021	Sites 136-330, G1	None	139	81
7022	Sites 136-330, G1	None	140	81
7023	Sites 136-330, G1	None	141	81
7024	Sites 136-330, G1	None	142	81
7025	Sites 136-330, G1	None	143	81
7026	Sites 136-330, G1	None	144	81
7027	Sites 136-330, G1	None	145	81
7028	Sites 136-330, G1	None	146	81
7029	Sites 136-330, G1	None	147	81
7030	Sites 136-330, G1	None	148	81
7031	Sites 136-330, G1	None	149	81
7032	Sites 136-330, G1	None	150	81
7033	Sites 136-330, G1	None	151	81
7034	Sites 136-330, G1	None	152	81
7035	Sites 136-330, G1	None	153	81
7036	Sites 136-330, G1	None	154	81
7037	Sites 136-330, G1	None	155	81
7038	Sites 136-330, G1	None	156	81
7039	Sites 136-330, G1	None	157	81
7040	Sites 136-330, G1	None	158	81
7041	Sites 136-330, G1	None	159	81
7042	Sites 136-330, G1	None	160	81
7043	Sites 136-330, G1	None	161	81
7044	Sites 136-330, G1	None	162	81
7045	Sites 136-330, G1	None	163	81
7046	Sites 136-330, G1	None	164	81
7047	Sites 136-330, G1	None	165	81
7048	Sites 136-330, G1	None	166	81
7049	Sites 136-330, G1	None	167	81
7050	Sites 136-330, G1	None	168	81
7051	Sites 136-330, G1	None	169	81
7052	Sites 136-330, G1	None	170	81
7053	Sites 136-330, G1	None	171	81
7054	Sites 136-330, G1	None	172	81
7055	Sites 136-330, G1	None	173	81
7056	Sites 136-330, G1	None	174	81
7057	Sites 136-330, G1	None	175	81
7058	Sites 136-330, G1	None	176	81
7059	Sites 136-330, G1	None	177	81
7060	Sites 136-330, G1	None	178	81
7061	Sites 136-330, G1	None	179	81
7062	Sites 136-330, G1	None	180	81
7063	Sites 136-330, G1	None	181	81
7064	Sites 136-330, G1	None	182	81
7065	Sites 136-330, G1	None	183	81
7066	Sites 136-330, G1	None	184	81
7067	Sites 136-330, G1	None	185	81
7068	Sites 136-330, G1	None	186	81
7069	Sites 136-330, G1	None	187	81
7070	Sites 136-330, G1	None	188	81
7071	Sites 136-330, G1	None	189	81
7072	Sites 136-330, G1	None	190	81
7073	Sites 136-330, G1	None	191	81
7074	Sites 136-330, G1	None	192	81
7075	Sites 136-330, G1	None	193	81
7076	Sites 136-330, G1	None	194	81
7077	Sites 136-330, G1	None	195	81
7078	Sites 136-330, G1	None	196	81
7079	Sites 136-330, G1	None	197	81
7080	Sites 136-330, G1	None	198	81
7081	Sites 136-330, G1	None	199	81
7082	Sites 136-330, G1	None	200	81
7083	Sites 136-330, G1	None	201	81
7084	Sites 136-330, G1	None	202	81
7085	Sites 136-330, G1	None	203	81
7086	Sites 136-330, G1	None	204	81
7087	Sites 136-330, G1	None	205	81
7088	Sites 136-330, G1	None	206	81
7089	Sites 136-330, G1	None	207	81
7090	Sites 136-330, G1	None	208	81
7091	Sites 136-330, G1	None	209	81
7092	Sites 136-330, G1	None	210	81
7093	Sites 136-330, G1	None	211	81
7094	Sites 136-330, G1	None	212	81
7095	Sites 136-330, G1	None	213	81
7096	Sites 136-330, G1	None	214	81
7097	Sites 136-330, G1	None	215	81
7098	Sites 136-330, G1	None	216	81
7099	Sites 136-330, G1	None	217	81
7100	Sites 136-330, G1	None	218	81
7101	Sites 136-330, G1	None	219	81
7102	Sites 136-330, G1	None	220	81
7103	Sites 136-330, G1	None	221	81
7104	Sites 136-330, G1	None	222	81
7105	Sites 136-330, G1	None	223	81
7106	Sites 136-330, G1	None	224	81
7107	Sites 136-330, G1	None	225	81
7108	Sites 136-330, G1	None	226	81
7109	Sites 136-330, G1	None	227	81
7110	Sites 136-330, G1	None	228	81
7111	Sites 136-330, G1	None	229	81
7112	Sites 136-330, G1	None	230	81
7113	Sites 136-330, G1	None	231	81
7114	Sites 136-330, G1	None	232	81
7115	Sites 136-330, G1	None	233	81
7116	Sites 136-330, G1	None	234	81
7117	Sites 136-330, G1	None	235	81
7118	Sites 136-330, G1	None	236	81
7119	Sites 136-330, G1	None	237	81
7120	Sites 136-330, G1	None	238	81
7121	Sites 136-330, G1	None	239	81
7122	Sites 136-330, G1	None	240	81
7123	Sites 136-330, G1	None	241	81
7124	Sites 136-330, G1	None	242	81
7125	Sites 136-330, G1	None	243	81
7126	Sites 136-330, G1	None	244	81
7127	Sites 136-330, G1	None	245	81
7128	Sites 136-330, G1	None	246	81
7129	Sites 136-330, G1	None	247	81
7130	Sites 136-330, G1	None	248	81
7131	Sites 136-330, G1	None	249	81
7132	Sites 136-330, G1	None	250	81
7133	Sites 136-330, G1	None	251	81
7134	Sites 136-330, G1	None	252	81
7135	Sites 136-330, G1	None	253	81
7136	Sites 136-330, G1	None	254	81
7137	Sites 136-330, G1	None	255	81
7138	Sites 136-330, G1	None	256	81
7139	Sites 136-330, G1	None	257	81
7140	Sites 136-330, G1	None	258	81
7141	Sites 136-330, G1	None	259	81
7142	Sites 136-330, G1	None	260	81
7143	Sites 136-330, G1	None	261	81
7144	Sites 136-330, G1	None	262	81
7145	Sites 136-330, G1	None	263	81
7146	Sites 136-330, G1	None	264	81
7147	Sites 136-330, G1	None	265	81
7148	Sites 136-330, G1	None	266	81
7149	Sites 136-330, G1	None	267	81
7150	Sites 136-330, G1	None	268	81
7151	Sites 136-330, G1	None	269	81
7152	Sites 136-330, G1	None	270	81
7153	Sites 136-330, G1	None	271	81
7154	Sites 136-330, G1	None	272	81
7155	Sites 136-330, G1	None	273	81
7156	Sites 136-330, G1	None	274	81
7157	Sites 136-330, G1	None	275	81
7158	Sites 136-330, G1	None	276	81
7159	Sites 136-330, G1	None	277	81
7160	Sites 136-330, G1	None	278	81
7161	Sites 136-330, G1	None	279	81
7162	Sites 136-330, G1	None	280	81
7163	Sites 136-330, G1	None	281	81
7164	Sites 136-330, G1	None	282	81
7165	Sites 136-330, G1	None	283	81
7166	Sites 136-330, G1	None	284	81
7167	Sites 136-330, G1	None	285	81
7168	Sites 136-330, G1	None	286	81
7169	Sites 136-330, G1	None	287	81
7170	Sites 136-330, G1	None	288	81
7171	Sites 136-330, G1	None	289	81
7172	Sites 136-330, G1	None	290	81
7173	Sites 136-330, G1	None	291	81
7174	Sites 136-330, G1	None	292	81
7175	Sites 136-330, G1	None	293	81
7176	Sites 136-330, G1	None	294	81
7177	Sites 136-330, G1	None	295	81
7178	Sites 136-330, G1	None	296	81
7179	Sites 136-330, G1	None	297	81
7180	Sites 136-330, G1	None	298	81
7181	Sites 136-330, G1	None	299	81
7182	Sites 136-330, G1	None	300	81
7183	Sites 136-330, G1	None	301	81
7184	Sites 136-330, G1	None	302	81
7185	Sites 136-330, G1	None	303	81
7186	Sites 136-330, G1	None	304	81
7187	Sites 136-330, G1	None	305	81
7188	Sites 136-330, G1	None	306	81
7189	Sites 136-330, G1	None	307	81
7190	Sites 136-330, G1	None	308	81
7191	Sites 136-330, G1	None	309	81
7192	Sites 136-330, G1	None	310	81
7193	Sites 136-330, G1	None	311	81
7194	Sites 136-330, G1	None	312	81
7195	Sites 136-330, G1	None	313	81
7196	Sites 136-330, G1	None	314	81
7197	Sites 136-330, G1	None	315	81
7198	Sites 136-330, G1	None	316	81
7199	Sites 136-330, G1	None	317	81
7200	Sites 136-330, G1	None	318	81
7201	Sites 136-330, G1	None	319	81
7202	Sites 136-330, G1	None	320	81
7203	Sites 136-330, G1	None	321	81
7204	Sites 136-330, G1	None	322	81
7205	Sites 136-330, G1	None	323	81
7206	Sites 136-330, G1	None	324	81
7207	Sites 136-330, G1	None	325	81
7208	Sites 136-330, G1	None	326	81
7209	Sites 136-330, G1	None	327	81
7210	Sites 136-330, G1	None	328	81
7211	Sites 136-330, G1	None	329	81
7212	Sites 136-330, G1	None	330	81
7213	Buttle Lake Campground	None	G1	81
7214	None	None	5	82
7215	None	None	6	82
7216	None	None	7	82
7217	None	None	8	82
7218	None	None	9	82
7219	None	None	10	82
7220	None	None	11	82
7221	None	None	12	82
7222	None	None	13	82
7223	None	None	14	82
7224	None	None	15	82
7225	None	None	16	82
7226	None	None	17	82
7227	None	None	18	82
7228	None	None	19	82
7229	None	None	20	82
7230	None	None	21	82
7231	None	None	22	82
7232	None	None	23	82
7233	None	None	1	84
7234	None	None	2	84
7235	None	None	3	84
7236	None	None	4	84
7237	None	None	5	84
7238	None	None	6	84
7239	None	None	7	84
7240	None	None	8	84
7241	None	None	9	84
7242	None	None	10	84
7243	None	None	11	84
7244	None	None	12	84
7245	None	None	13	84
7246	None	None	14	84
7247	None	None	15	84
7248	None	None	16	84
7249	None	None	17	84
7250	None	None	18	84
7251	None	None	19	84
7252	None	None	20	84
7253	None	None	21	84
7254	None	None	22	84
7255	None	None	23	84
7256	None	None	24	84
7257	None	None	19	85
7258	None	None	20	85
7259	None	None	21	85
7260	None	None	22	85
7261	None	None	23	85
7262	None	None	24	85
7263	None	None	25	85
7264	None	None	26	85
7265	None	None	27	85
7266	None	None	28	85
7267	None	None	29	85
7268	None	None	30	85
7269	None	None	1	86
7270	None	None	2	86
7271	None	None	3	86
7272	None	None	4	86
7273	None	None	5	86
7274	None	None	6	86
7275	None	None	7	86
7276	None	None	8	86
7277	None	None	9	86
7278	None	None	10	86
7279	None	None	11	86
7280	None	None	12	86
7281	None	None	13	86
7282	None	None	14	86
7283	None	None	15	86
7284	None	None	16	86
7285	None	None	17	86
7286	None	None	18	86
7287	None	None	19	86
7288	None	None	20	86
7289	None	None	21	86
7290	None	None	22	86
7291	None	None	23	86
7292	None	None	24	86
7293	None	None	25	86
7294	None	None	26	86
7295	None	None	27	86
7296	None	None	28	86
7297	None	None	29	86
7298	None	None	30	86
7299	None	None	31	86
7300	None	None	32	86
7301	None	None	33	86
7302	None	None	34	86
7303	None	None	35	86
7304	None	None	36	86
7305	None	None	37	86
7306	None	None	38	86
7307	None	None	39	86
7308	None	None	40	86
7309	None	None	41	86
7310	None	None	42	86
7311	None	None	43	86
7312	None	None	44	86
7313	None	None	45	86
7314	None	None	46	86
7315	None	None	47	86
7316	None	None	48	86
7317	None	None	49	86
7318	None	None	50	86
7319	None	None	51	86
7320	None	None	52	86
7321	None	None	53	86
7322	None	None	54	86
7323	None	None	55	86
7324	None	None	56	86
7325	None	None	57	86
7326	None	None	58	86
7327	None	None	T1	86
7328	None	None	T2	86
7329	None	None	T3	86
7330	None	None	T4	86
7331	None	None	T5	86
7332	None	None	2	87
7333	None	None	3	87
7334	None	None	4	87
7335	None	None	5	87
7336	None	None	6	87
7337	None	None	7	87
7338	None	None	8	87
7339	None	None	9	87
7340	None	None	10	87
7341	None	None	11	87
7342	None	None	12	87
7343	None	None	13	87
7344	None	None	14	87
7345	None	None	15	87
7346	None	None	16	87
7347	None	None	17	87
7348	None	None	18	87
7349	None	None	19	87
7350	None	None	20	87
7351	None	None	21	87
7352	None	None	22	87
7353	None	None	23	87
7354	None	None	1	88
7355	None	None	2	88
7356	None	None	3	88
7357	None	None	4	88
7358	None	None	5	88
7359	None	None	6	88
7360	None	None	7	88
7361	None	None	8	88
7362	None	None	9	88
7363	None	None	10	88
7364	None	None	11	88
7365	None	None	12	88
7366	None	None	13	88
7367	None	None	14	88
7368	None	None	15	88
7369	None	None	16	88
7370	None	None	17	88
7371	None	None	18	88
7372	None	None	19	88
7373	None	None	20	88
7374	None	None	21	88
7375	None	None	22	88
7376	None	None	23	88
7377	None	None	24	88
7378	None	None	25	88
7379	None	None	26	88
7380	None	None	27	88
7381	None	None	1	89
7382	None	None	2	89
7383	None	None	3	89
7384	None	None	4	89
7385	None	None	5	89
7386	None	None	6	89
7387	None	None	7	89
7388	None	None	8	89
7389	None	None	9	89
7390	None	None	10	89
7391	None	None	11	89
7392	None	None	12	89
7393	None	None	13	89
7394	None	None	14	89
7395	None	None	15	89
7396	None	None	16	89
7397	None	None	17	89
7398	None	None	18	89
7399	None	None	19	89
7400	None	None	20	89
7401	None	None	21	89
7402	None	None	22	89
7403	None	None	23	89
7404	None	None	24	89
7405	None	None	25	89
7406	None	None	26	89
7407	None	None	27	89
7408	None	None	28	89
7409	None	None	29	89
7410	None	None	30	89
7411	None	None	31	89
7412	None	None	32	89
7413	None	None	33	89
7414	None	None	34	89
7415	None	None	35	89
7416	None	None	36	89
7417	None	None	37	89
7418	None	None	38	89
7419	None	None	39	89
7420	None	None	40	89
7421	None	None	41	89
7422	None	None	42	89
7423	None	None	43	89
7424	None	None	44	89
7425	None	None	45	89
7426	None	None	46	89
7427	None	None	47	89
7428	None	None	48	89
7429	None	None	49	89
7430	None	None	50	89
7431	None	None	51	89
7432	None	None	52	89
7433	None	None	53	89
7434	None	None	54	89
7435	None	None	55	89
7436	None	None	56	89
7437	None	None	57	89
7438	None	None	58	89
7439	None	None	59	89
7440	None	None	60	89
7441	None	None	61	89
7442	None	None	62	89
7443	None	None	63	89
7444	None	None	64	89
7445	None	None	65	89
7446	None	None	66	89
7447	None	None	67	89
7448	None	None	68	89
7449	None	None	69	89
7450	None	None	70	89
7451	None	None	71	89
7452	None	None	72	89
7453	None	None	73	89
7454	None	None	74	89
7455	None	None	75	89
7456	None	None	76	89
7457	None	None	77	89
7458	None	None	78	89
7459	None	None	79	89
7460	None	None	80	89
7461	None	None	81	89
7462	None	None	82	89
7463	None	None	83	89
7464	None	None	84	89
7465	None	None	85	89
7466	None	None	86	89
7467	None	None	G1 - Driftwood Bay	89
7468	None	None	R3	89
7469	None	None	R4	89
7470	None	None	R5	89
7471	None	None	R6	89
7472	None	None	R7	89
7473	None	None	R10	89
7474	None	None	R11	89
7475	None	None	R12	89
7476	None	None	R13	89
7477	None	None	R14	89
7478	None	None	R15	89
7479	None	None	R16	89
7480	None	None	R17	89
7481	None	None	R18	89
7482	None	None	R19	89
7483	None	None	R20	89
7484	None	None	R21	89
7485	None	None	R22	89
7486	None	None	R23	89
7487	None	None	R24	89
7488	None	None	R25	89
7489	None	None	R26	89
7490	None	None	R27	89
7491	None	None	R28	89
7492	None	None	R29	89
7493	None	None	R30	89
7494	None	None	R31	89
7495	None	None	R32	89
7496	None	None	R33	89
7497	None	None	R34	89
7498	None	None	R35	89
7499	None	None	R36	89
7500	None	None	R37	89
7501	None	None	R38	89
7502	None	None	R39	89
7503	None	None	R40	89
7504	None	None	R41	89
7505	None	None	R42	89
7506	None	None	R43	89
7507	None	None	R44	89
7508	None	None	R45	89
7509	None	None	R46	89
7510	None	None	R47	89
7511	None	None	R48	89
7512	None	None	R49	89
7513	None	None	R50	89
7514	None	None	R51	89
7515	None	None	R52	89
7516	None	None	R53	89
7517	None	None	R54	89
7518	None	None	R55	89
7519	None	None	R56	89
7520	None	None	R57	89
7521	None	None	R58	89
7522	None	None	R59	89
7523	None	None	R60	89
7524	None	None	R61	89
7525	None	None	R62	89
7526	None	None	R63	89
7527	None	None	R64	89
7528	None	None	R65	89
7529	None	None	R66	89
7530	None	None	R67	89
7531	None	None	R68	89
7532	None	None	R69	89
7533	None	None	R70	89
7534	None	None	R71	89
7535	None	None	R72	89
7536	None	None	R73	89
7537	None	None	R74	89
7538	None	None	R75	89
7539	None	None	G2 - Karst Creek	89
7540	None	None	G3 - Corteau Lake Backcountry	89
7541	Sites 1-35 and Group Picnic Area	None	5	90
7542	Sites 1-35 and Group Picnic Area	None	6	90
7543	Sites 1-35 and Group Picnic Area	None	7	90
7544	Sites 1-35 and Group Picnic Area	None	9	90
7545	Sites 1-35 and Group Picnic Area	None	11	90
7546	Sites 1-35 and Group Picnic Area	None	12	90
7547	Sites 1-35 and Group Picnic Area	None	13	90
7548	Sites 1-35 and Group Picnic Area	None	14	90
7549	Sites 1-35 and Group Picnic Area	None	15	90
7550	Sites 1-35 and Group Picnic Area	None	16	90
7551	Sites 1-35 and Group Picnic Area	None	17	90
7552	Sites 1-35 and Group Picnic Area	None	18	90
7553	Sites 1-35 and Group Picnic Area	None	19	90
7554	Sites 1-35 and Group Picnic Area	None	20	90
7555	Sites 1-35 and Group Picnic Area	None	21	90
7556	Sites 1-35 and Group Picnic Area	None	22	90
7557	Sites 1-35 and Group Picnic Area	None	23	90
7558	Sites 1-35 and Group Picnic Area	None	24	90
7559	Sites 1-35 and Group Picnic Area	None	25	90
7560	Sites 1-35 and Group Picnic Area	None	26	90
7561	Sites 1-35 and Group Picnic Area	None	27	90
7562	Sites 1-35 and Group Picnic Area	None	28	90
7563	Sites 1-35 and Group Picnic Area	None	29	90
7564	Sites 1-44, PS-1	None	9	91
7565	Sites 1-44, PS-1	None	10	91
7566	Sites 1-44, PS-1	None	11	91
7567	Sites 1-44, PS-1	None	12	91
7568	Sites 1-44, PS-1	None	13	91
7569	Sites 1-44, PS-1	None	14	91
7570	Sites 1-44, PS-1	None	15	91
7571	Sites 1-44, PS-1	None	24	91
7572	Sites 1-44, PS-1	None	25	91
7573	Sites 1-44, PS-1	None	26	91
7574	Sites 1-44, PS-1	None	27	91
7575	Sites 1-44, PS-1	None	28	91
7576	Sites 1-44, PS-1	None	29	91
7577	Sites 1-44, PS-1	None	30	91
7578	Sites 1-44, PS-1	None	31	91
7579	Sites 1-44, PS-1	None	32	91
7580	Sites 1-44, PS-1	None	33	91
7581	Sites 1-44, PS-1	None	40	91
7582	Sites 1-44, PS-1	None	41	91
7583	Sites 1-44, PS-1	None	42	91
7584	Sites 1-44, PS-1	None	43	91
7585	None	None	1	92
7586	None	None	2	92
7587	None	None	3	92
7588	None	None	4	92
7589	None	None	5	92
7590	None	None	6	92
7591	None	None	7	92
7592	None	None	8	92
7593	None	None	9	92
7594	None	None	10	92
7595	None	None	11	92
7596	None	None	12	92
7597	None	None	13	92
7598	None	None	14	92
7599	None	None	15	92
7600	None	None	16	92
7601	None	None	17	92
7602	None	None	18	92
7603	None	None	19	92
7604	None	None	20	92
7605	None	None	21	92
7606	None	None	22	92
7607	None	None	23	92
7608	None	None	24	92
7609	None	None	25	92
7610	None	None	26	92
7611	None	None	27	92
7612	None	None	28	92
7613	None	None	29	92
7614	None	None	30	92
7615	None	None	31	92
7616	None	None	32	92
7617	None	None	33	92
7618	None	None	34	92
7619	None	None	35	92
7620	None	None	36	92
7621	None	None	37	92
7622	None	None	38	92
7623	None	None	39	92
7624	None	None	40	92
7625	None	None	41	92
7626	Sites 1-31	None	1	93
7627	Sites 1-31	None	2	93
7628	Sites 1-31	None	3	93
7629	Sites 1-31	None	4	93
7630	Sites 1-31	None	5	93
7631	Sites 1-31	None	6	93
7632	Sites 1-31	None	7	93
7633	Sites 1-31	None	8	93
7634	Sites 1-31	None	9	93
7635	Sites 1-31	None	10	93
7636	Sites 1-31	None	11	93
7637	Sites 1-31	None	12	93
7638	Sites 1-31	None	13	93
7639	Sites 1-31	None	14	93
7640	Sites 1-31	None	15	93
7641	Sites 1-31	None	16	93
7642	Sites 1-31	None	17	93
7643	Sites 1-31	None	18	93
7644	Sites 1-31	None	19	93
7645	Sites 1-31	None	20	93
7646	Sites 1-31	None	21	93
7647	Sites 1-31	None	22	93
7648	Sites 1-31	None	23	93
7649	Sites 1-31	None	24	93
7650	Sites 1-31	None	25	93
7651	Sites 1-31	None	26	93
7652	Sites 1-31	None	27	93
7653	Sites 1-31	None	28	93
7654	Sites 1-31	None	29	93
7655	Sites 1-31	None	30	93
7656	Sites 1-31	None	31	93
7657	Bighorn Campground	None	71	94
7658	Bighorn Campground	None	72	94
7659	Bighorn Campground	None	73	94
7660	Bighorn Campground	None	74	94
7661	Bighorn Campground	None	75	94
7662	Bighorn Campground	None	76	94
7663	Bighorn Campground	None	77	94
7664	Bighorn Campground	None	78	94
7665	Bighorn Campground	None	79	94
7666	Bighorn Campground	None	80	94
7667	Bighorn Campground	None	81	94
7668	Bighorn Campground	None	82	94
7669	Bighorn Campground	None	83	94
7670	Bighorn Campground	None	84	94
7671	Bighorn Campground	None	85	94
7672	Bighorn Campground	None	86	94
7673	Main Campground	None	18	94
7674	Main Campground	None	19	94
7675	Main Campground	None	20	94
7676	Main Campground	None	21	94
7677	Main Campground	None	22	94
7678	Main Campground	None	23	94
7679	Main Campground	None	24	94
7680	Main Campground	None	25	94
7681	Main Campground	None	26	94
7682	Main Campground	None	27	94
7683	Main Campground	None	28	94
7684	Main Campground	None	29	94
7685	Main Campground	None	30	94
7686	Main Campground	None	31	94
7687	Main Campground	None	32	94
7688	Main Campground	None	33	94
7689	Main Campground	None	34	94
7690	Main Campground	None	35	94
7691	Main Campground	None	36	94
7692	Main Campground	None	37	94
7693	Main Campground	None	38	94
7694	Main Campground	None	39	94
7695	Main Campground	None	40	94
7696	Main Campground	None	41	94
7697	Main Campground	None	42	94
7698	Main Campground	None	43	94
7699	Main Campground	None	44	94
7700	Main Campground	None	45	94
7701	Main Campground	None	46	94
7702	Main Campground	None	47	94
7703	Lakeside	None	L2	95
7704	Lakeside	None	L3	95
7705	Lakeside	None	L4	95
7706	Lakeside	None	L5	95
7707	Lakeside	None	L6	95
7708	Lakeside	None	L7	95
7709	Lakeside	None	L8	95
7710	Lakeside	None	L9	95
7711	Lakeside	None	L10	95
7712	Lakeside	None	L11	95
7713	Lakeside	None	L12	95
7714	Lakeside	None	L13	95
7715	Lakeside	None	L14	95
7716	Lakeside	None	L15	95
7717	Lakeside	None	L16	95
7718	Lakeside	None	L17	95
7719	Lakeside	None	L18	95
7720	Lakeside	None	L19	95
7721	Lakeside	None	L20	95
7722	Lakeside	None	L21	95
7723	Lakeside	None	L22	95
7724	Lakeside	None	L23	95
7725	Lakeside	None	L24	95
7726	Lakeside	None	L25	95
7727	Lakeside	None	L26	95
7728	Lakeside	None	L27	95
7729	Lakeside	None	L28	95
7730	Lakeside	None	L29	95
7731	Lakeside	None	L30	95
7732	Lakeside	None	L31	95
7733	Lakeside	None	L32	95
7734	Lakeside	None	L33	95
7735	Lakeside	None	L34	95
7736	Lakeside	None	L35	95
7737	Lakeside	None	L36	95
7738	Lakeside	None	L37	95
7739	Lakeside	None	L37A	95
7740	Lakeside	None	L38	95
7741	Lakeside	None	L39	95
7742	Lakeside	None	L40	95
7743	Lakeside	None	L41	95
7744	Lakeside	None	L42	95
7745	Lakeside	None	L43	95
7746	Lakeside	None	L44	95
7747	Lakeside	None	L45	95
7748	Lakeside	None	L46	95
7749	Lakeside	None	L47	95
7750	Lakeside	None	L48	95
7751	Lakeside	None	L49	95
7752	Lakeside	None	L50	95
7753	Lakeside	None	L51	95
7754	Lakeside	None	L52	95
7755	Lakeside	None	L52A	95
7756	Lakeside	None	L53	95
7757	Lakeside	None	L54	95
7758	Lakeside	None	L55	95
7759	Lakeside	None	L56	95
7760	Lakeside	None	L57	95
7761	Lakeside	None	L58	95
7762	Lakeside	None	L59	95
7763	Lakeside	None	L60	95
7764	Fisheries Pool	None	FP3	96
7765	Fisheries Pool	None	FP4	96
7766	Fisheries Pool	None	FP5	96
7767	Atnarko	None	A1	96
7768	Atnarko	None	A2	96
7769	Atnarko	None	A3	96
7770	Atnarko	None	A12	96
7771	Atnarko	None	A13	96
7772	Atnarko	None	A14	96
7773	Atnarko	None	A15	96
7774	Campground	None	1	97
7775	Campground	None	2	97
7776	Campground	None	3	97
7777	Campground	None	4	97
7778	Campground	None	5	97
7779	Campground	None	6	97
7780	Campground	None	7	97
7781	Campground	None	8	97
7782	Campground	None	9	97
7783	Campground	None	10	97
7784	Campground	None	11	97
7785	Campground	None	12	97
7786	Campground	None	13	97
7787	Campground	None	14	97
7788	Campground	None	15	97
7789	Campground	None	16	97
7790	Campground	None	17	97
7791	Campground	None	18	97
7792	Campground	None	19	97
7793	Campground	None	20	97
7794	Campground	None	21	97
7795	Campground	None	22	97
7796	Campground	None	23	97
7797	Campground	None	24	97
7798	Campground	None	25	97
7799	Campground	None	8	98
7800	Campground	None	12	98
7801	Campground	None	16	98
7802	Campground	None	24	98
7803	Campground	None	34	98
7804	Campground	None	36	98
7805	None	None	26	99
7806	None	None	27	99
7807	None	None	28	99
7808	None	None	29	99
7809	None	None	30	99
7810	None	None	31	99
7811	None	None	32	99
7812	None	None	33	99
7813	None	None	34	99
7814	None	None	35	99
7815	None	None	36	99
7816	None	None	37	99
7817	None	None	38	99
7818	None	None	39	99
7819	None	None	40	99
7820	None	None	41	99
7821	None	None	42	99
7822	None	None	43	99
7823	None	None	44	99
7824	None	None	45	99
7825	None	None	46	99
7826	None	None	47	99
7827	None	None	63	99
7828	None	None	64	99
7829	None	None	65	99
7830	None	None	66	99
7831	None	None	67	99
7832	None	None	68	99
7833	None	None	69	99
7834	None	None	70	99
7835	None	None	71	99
7836	None	None	72	99
7837	None	None	73	99
7838	None	None	74	99
7839	None	None	75	99
7840	None	None	76	99
7841	None	None	77	99
7842	None	None	78	99
7843	None	None	79	99
7844	None	None	80	99
7845	None	None	81	99
7846	None	None	83A	99
7847	None	None	83B	99
7848	None	None	84	99
7849	None	None	85	99
7850	None	None	86	99
7851	None	None	87	99
7852	None	None	88	99
7853	None	None	89	99
7854	None	None	90	99
7855	None	None	91	99
7856	None	None	92	99
7857	None	None	93	99
7858	None	None	94	99
7859	None	None	95	99
7860	None	None	96	99
7861	None	None	97	99
7862	None	None	98	99
7863	None	None	99	99
7864	None	None	100	99
7865	None	None	101	99
7866	 Mahood Lake 	None	1	100
7867	 Mahood Lake 	None	2	100
7868	 Mahood Lake 	None	3	100
7869	 Mahood Lake 	None	4	100
7870	 Mahood Lake 	None	4A	100
7871	 Mahood Lake 	None	5	100
7872	 Mahood Lake 	None	6	100
7873	 Mahood Lake 	None	6A	100
7874	 Mahood Lake 	None	7	100
7875	 Mahood Lake 	None	8	100
7876	 Mahood Lake 	None	9	100
7877	 Mahood Lake 	None	10	100
7878	 Mahood Lake 	None	11	100
7879	 Mahood Lake 	None	11A	100
7880	 Mahood Lake 	None	12	100
7881	 Mahood Lake 	None	13	100
7882	 Mahood Lake 	None	13A	100
7883	 Mahood Lake 	None	14	100
7884	 Mahood Lake 	None	15	100
7885	 Mahood Lake 	None	16	100
7886	 Mahood Lake 	None	17	100
7887	 Mahood Lake 	None	18	100
7888	 Mahood Lake 	None	19	100
7889	 Mahood Lake 	None	20	100
7890	 Mahood Lake 	None	21	100
7891	 Mahood Lake 	None	22	100
7892	 Mahood Lake 	None	23	100
7893	 Mahood Lake 	None	24	100
7894	 Mahood Lake 	None	25	100
7895	 Mahood Lake 	None	26	100
7896	 Mahood Lake 	None	27	100
7897	 Mahood Lake 	None	28	100
7898	 Mahood Lake 	None	29	100
7899	 Mahood Lake 	None	29A	100
7900	 Mahood Lake 	None	30	100
7901	 Mahood Lake 	None	31	100
7902	 Mahood Lake 	None	32	100
7903	None	None	63	100
7904	None	None	64	100
7905	None	None	65	100
7906	None	None	66	100
7907	None	None	67	100
7908	None	None	68	100
7909	None	None	69	100
7910	None	None	70	100
7911	None	None	71	100
7912	None	None	72	100
7913	None	None	73	100
7914	None	None	74	100
7915	None	None	75	100
7916	None	None	76	100
7917	None	None	77	100
7918	None	None	78	100
7919	None	None	79	100
7920	None	None	80	100
7921	None	None	81	100
7922	None	None	83A	100
7923	None	None	83B	100
7924	 Clearwater Lake 	None	C1	100
7925	 Clearwater Lake 	None	C2	100
7926	 Clearwater Lake 	None	C3	100
7927	 Clearwater Lake 	None	C4	100
7928	 Clearwater Lake 	None	C5	100
7929	 Clearwater Lake 	None	C6	100
7930	 Clearwater Lake 	None	C7	100
7931	 Clearwater Lake 	None	C8	100
7932	 Clearwater Lake 	None	C9	100
7933	 Clearwater Lake 	None	C10	100
7934	 Clearwater Lake 	None	C11	100
7935	 Clearwater Lake 	None	C12	100
7936	 Clearwater Lake 	None	C13	100
7937	 Clearwater Lake 	None	C14	100
7938	 Clearwater Lake 	None	C15	100
7939	 Clearwater Lake 	None	C16	100
7940	 Clearwater Lake 	None	C17	100
7941	 Clearwater Lake 	None	C18	100
7942	 Clearwater Lake 	None	C19	100
7943	 Clearwater Lake 	None	C20	100
7944	 Clearwater Lake 	None	C21	100
7945	 Clearwater Lake 	None	C22	100
7946	 Clearwater Lake 	None	C23	100
7947	 Clearwater Lake 	None	C24	100
7948	 Clearwater Lake 	None	C25	100
7949	 Clearwater Lake 	None	C26	100
7950	 Clearwater Lake 	None	C27	100
7951	 Clearwater Lake 	None	C28	100
7952	 Clearwater Lake 	None	C29	100
7953	 Clearwater Lake 	None	C30	100
7954	 Clearwater Lake 	None	C31	100
7955	 Clearwater Lake 	None	C32	100
7956	 Clearwater Lake 	None	C33	100
7957	 Clearwater Lake 	None	C34	100
7958	 Clearwater Lake 	None	C35	100
7959	 Clearwater Lake 	None	C36	100
7960	 Clearwater Lake 	None	C37	100
7961	 Clearwater Lake 	None	C38	100
7962	 Clearwater Lake 	None	C39	100
7963	 Clearwater Lake 	None	C40	100
7964	 Falls Creek 	None	F41	100
7965	 Falls Creek 	None	F42	100
7966	 Falls Creek 	None	F43	100
7967	 Falls Creek 	None	F44	100
7968	 Falls Creek 	None	F45	100
7969	 Falls Creek 	None	F46	100
7970	 Falls Creek 	None	F47	100
7971	 Falls Creek 	None	F48	100
7972	 Falls Creek 	None	F49	100
7973	 Falls Creek 	None	F50	100
7974	 Falls Creek 	None	F51	100
7975	 Falls Creek 	None	F52	100
7976	 Falls Creek 	None	F53	100
7977	 Falls Creek 	None	F54	100
7978	 Falls Creek 	None	F55	100
7979	 Falls Creek 	None	F56	100
7980	 Falls Creek 	None	F57	100
7981	 Falls Creek 	None	F58	100
7982	 Falls Creek 	None	F59	100
7983	 Falls Creek 	None	F60	100
7984	 Falls Creek 	None	F61	100
7985	 Falls Creek 	None	F62	100
7986	 Falls Creek 	None	F63	100
7987	 Falls Creek 	None	F64	100
7988	 Falls Creek 	None	F65	100
7989	 Falls Creek 	None	F66	100
7990	 Falls Creek 	None	F67	100
7991	 Falls Creek 	None	F68	100
7992	 Falls Creek 	None	F69	100
7993	 Falls Creek 	None	F70	100
7994	 Falls Creek 	None	F71	100
7995	 Falls Creek 	None	F72	100
7996	 Falls Creek 	None	F73	100
7997	 Falls Creek 	None	F74	100
7998	 Falls Creek 	None	F75	100
7999	 Falls Creek 	None	F76	100
8000	 Falls Creek 	None	F77	100
8001	 Falls Creek 	None	F78	100
8002	 Falls Creek 	None	F79	100
8003	 Falls Creek 	None	F80	100
8004	 Falls Creek 	None	F80A	100
8005	Sites 1-59	None	1	101
8006	Sites 1-59	None	2	101
8007	Sites 1-59	None	3	101
8008	Sites 1-59	None	4	101
8009	Sites 1-59	None	5	101
8010	Sites 1-59	None	6	101
8011	Sites 1-59	None	7	101
8012	Sites 1-59	None	8	101
8013	Sites 1-59	None	9	101
8014	Sites 1-59	None	10	101
8015	Sites 1-59	None	11	101
8016	Sites 1-59	None	12	101
8017	Sites 1-59	None	13	101
8018	Sites 1-59	None	14	101
8019	Sites 1-59	None	15	101
8020	Sites 1-59	None	16	101
8021	Sites 1-59	None	17	101
8022	Sites 1-59	None	18	101
8023	Sites 1-59	None	19	101
8024	Sites 1-59	None	20	101
8025	Sites 1-59	None	21	101
8026	Sites 1-59	None	22	101
8027	Sites 1-59	None	23	101
8028	Sites 1-59	None	24	101
8029	Sites 1-59	None	34	101
8030	Sites 1-59	None	35	101
8031	Sites 1-59	None	36	101
8032	Sites 1-59	None	37	101
8033	Sites 1-59	None	56	101
8034	Sites 1-59	None	57	101
8035	Sites 1-59	None	58	101
8036	Sites 1-59	None	59	101
8037	Sites 25-66	None	35	102
8038	Sites 25-66	None	36	102
8039	Sites 25-66	None	37	102
8040	Sites 25-66	None	38	102
8041	Sites 25-66	None	39	102
8042	Sites 25-66	None	40	102
8043	Sites 25-66	None	41	102
8044	Sites 25-66	None	42	102
8045	Sites 25-66	None	43	102
8046	Sites 25-66	None	44	102
8047	Sites 25-66	None	45	102
8048	Sites 25-66	None	46	102
8049	Sites 25-66	None	47	102
8050	Sites 25-66	None	48	102
8051	Sites 25-66	None	49	102
8052	Sites 25-66	None	50	102
8053	Sites 25-66	None	51	102
8054	Sites 25-66	None	52	102
8055	Sites 25-66	None	53	102
8056	Sites 25-66	None	54	102
8057	Sites 25-66	None	55	102
8058	Sites 25-66	None	56	102
8059	Sites 25-66	None	57	102
8060	Sites 25-66	None	58	102
8061	Mahood Lake	None	G2 - Mahood	100
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, password, "firstName", "lastName", confirmed, "billingAddress", "postalCode", city, province, country, subscription, "cId", "sId", scan, sub_day, active, phone_num, is_admin) FROM stdin;
2	cfarbatuk@gmail.com	$2b$12$/N0aYDNuQQtP4iplw2Dt0eG3wLEekN8JzUm5QwEC2er6su8cY7Kwe	col	far	t	22057 49 ave	\N	Langley	BC	Canada	jann_mem_silver	cus_MttEqZEX5VVvCa	sub_1MA5S6H3k8WZ4arfzXS3x8xs	7	\N	\N	\N	\N
3	admin@admin.ca	1	col	Far	f	123	123456	abby	bc	can	none	123	123	0	\N	\N	\N	\N
4	newuser@gmail.com	$2b$12$FRIZCJUEc9sgrIuXYMiTYeGCO8xOkweyN/C8uOHuCjX3bxVLWyazC	frank	job	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	cheema_mandy@hotmail.com	$2b$12$2B.91HFBK.01cUpuy6RhxeEZJHgMNkaEPmCdG/V2r.DeiiKhjo2yG	Mandy	Cheema	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	compscilife@proton.me	$2b$12$mrVLI/n5Bk.zhtG.X36M/OycBx0ALz.u9JRylErIsma5xvf.MqTDy	colton	william	t	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N
\.


--
-- Name: booking_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_data_id_seq', 1, false);


--
-- Name: booking_time_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_time_test_id_seq', 1, false);


--
-- Name: parks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.parks_id_seq', 102, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.sites_id_seq', 8061, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: booking_data booking_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_data
    ADD CONSTRAINT booking_data_pkey PRIMARY KEY (id);


--
-- Name: booking_time_test booking_time_test_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_time_test
    ADD CONSTRAINT booking_time_test_pkey PRIMARY KEY (id);


--
-- Name: parks parks_park_site_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parks
    ADD CONSTRAINT parks_park_site_key UNIQUE (park_site);


--
-- Name: parks parks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parks
    ADD CONSTRAINT parks_pkey PRIMARY KEY (id);


--
-- Name: role role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_name_key UNIQUE (name);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: booking_data booking_data_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_data
    ADD CONSTRAINT booking_data_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: roles_users roles_users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: roles_users roles_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: sites sites_park_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_park_id_fkey FOREIGN KEY (park_id) REFERENCES public.parks(id);


--
-- PostgreSQL database dump complete
--


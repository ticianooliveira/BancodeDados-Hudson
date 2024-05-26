PGDMP     	    )                 |            LojaDeAutomoveis    15.4    15.4 &                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    24699    LojaDeAutomoveis    DATABASE     �   CREATE DATABASE "LojaDeAutomoveis" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
 "   DROP DATABASE "LojaDeAutomoveis";
                postgres    false            �            1255    24748 $   inserirvenda(integer, integer, date) 	   PROCEDURE     �  CREATE PROCEDURE public.inserirvenda(IN p_carroid integer, IN p_vendedorcodigo integer, IN p_datavenda date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO Vendas (CarroID, VendedorCodigo, DataVenda)
    VALUES (p_CarroID, p_VendedorCodigo, p_DataVenda);
    RAISE NOTICE 'Venda inserida com sucesso: CarroID: %, VendedorCodigo: %, DataVenda: %', p_CarroID, p_VendedorCodigo, p_DataVenda;
END;
$$;
 l   DROP PROCEDURE public.inserirvenda(IN p_carroid integer, IN p_vendedorcodigo integer, IN p_datavenda date);
       public          postgres    false            �            1255    24746 
   logvenda()    FUNCTION       CREATE FUNCTION public.logvenda() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO VendaLogs (VendaID, CarroID, VendedorCodigo, DataVenda)
    VALUES (NEW.VendaID, NEW.CarroID, NEW.VendedorCodigo, NEW.DataVenda);
    RETURN NEW;
END;
$$;
 !   DROP FUNCTION public.logvenda();
       public          postgres    false            �            1259    24701    carros    TABLE       CREATE TABLE public.carros (
    id integer NOT NULL,
    marca character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL,
    ano integer NOT NULL,
    preco numeric(10,2) NOT NULL,
    cor character varying(30),
    quilometragem integer
);
    DROP TABLE public.carros;
       public         heap    postgres    false            �            1259    24700    carros_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.carros_id_seq;
       public          postgres    false    215            $           0    0    carros_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.carros_id_seq OWNED BY public.carros.id;
          public          postgres    false    214            �            1259    24739 	   vendalogs    TABLE     �   CREATE TABLE public.vendalogs (
    logid integer NOT NULL,
    vendaid integer,
    carroid integer,
    vendedorcodigo integer,
    datavenda date,
    logdata timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.vendalogs;
       public         heap    postgres    false            �            1259    24738    vendalogs_logid_seq    SEQUENCE     �   CREATE SEQUENCE public.vendalogs_logid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.vendalogs_logid_seq;
       public          postgres    false    221            %           0    0    vendalogs_logid_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.vendalogs_logid_seq OWNED BY public.vendalogs.logid;
          public          postgres    false    220            �            1259    24722    vendas    TABLE     �   CREATE TABLE public.vendas (
    vendaid integer NOT NULL,
    carroid integer NOT NULL,
    vendedorcodigo integer NOT NULL,
    datavenda date NOT NULL
);
    DROP TABLE public.vendas;
       public         heap    postgres    false            �            1259    24721    vendas_vendaid_seq    SEQUENCE     �   CREATE SEQUENCE public.vendas_vendaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.vendas_vendaid_seq;
       public          postgres    false    219            &           0    0    vendas_vendaid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.vendas_vendaid_seq OWNED BY public.vendas.vendaid;
          public          postgres    false    218            �            1259    24713 
   vendedores    TABLE     �   CREATE TABLE public.vendedores (
    vendedorid integer NOT NULL,
    nome character varying(100) NOT NULL,
    codigonumerico integer NOT NULL
);
    DROP TABLE public.vendedores;
       public         heap    postgres    false            �            1259    24712    vendedores_vendedorid_seq    SEQUENCE     �   CREATE SEQUENCE public.vendedores_vendedorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.vendedores_vendedorid_seq;
       public          postgres    false    217            '           0    0    vendedores_vendedorid_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.vendedores_vendedorid_seq OWNED BY public.vendedores.vendedorid;
          public          postgres    false    216            v           2604    24704 	   carros id    DEFAULT     f   ALTER TABLE ONLY public.carros ALTER COLUMN id SET DEFAULT nextval('public.carros_id_seq'::regclass);
 8   ALTER TABLE public.carros ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215            y           2604    24742    vendalogs logid    DEFAULT     r   ALTER TABLE ONLY public.vendalogs ALTER COLUMN logid SET DEFAULT nextval('public.vendalogs_logid_seq'::regclass);
 >   ALTER TABLE public.vendalogs ALTER COLUMN logid DROP DEFAULT;
       public          postgres    false    220    221    221            x           2604    24725    vendas vendaid    DEFAULT     p   ALTER TABLE ONLY public.vendas ALTER COLUMN vendaid SET DEFAULT nextval('public.vendas_vendaid_seq'::regclass);
 =   ALTER TABLE public.vendas ALTER COLUMN vendaid DROP DEFAULT;
       public          postgres    false    219    218    219            w           2604    24716    vendedores vendedorid    DEFAULT     ~   ALTER TABLE ONLY public.vendedores ALTER COLUMN vendedorid SET DEFAULT nextval('public.vendedores_vendedorid_seq'::regclass);
 D   ALTER TABLE public.vendedores ALTER COLUMN vendedorid DROP DEFAULT;
       public          postgres    false    217    216    217                      0    24701    carros 
   TABLE DATA           S   COPY public.carros (id, marca, modelo, ano, preco, cor, quilometragem) FROM stdin;
    public          postgres    false    215   �,                 0    24739 	   vendalogs 
   TABLE DATA           `   COPY public.vendalogs (logid, vendaid, carroid, vendedorcodigo, datavenda, logdata) FROM stdin;
    public          postgres    false    221   0                 0    24722    vendas 
   TABLE DATA           M   COPY public.vendas (vendaid, carroid, vendedorcodigo, datavenda) FROM stdin;
    public          postgres    false    219   V0                 0    24713 
   vendedores 
   TABLE DATA           F   COPY public.vendedores (vendedorid, nome, codigonumerico) FROM stdin;
    public          postgres    false    217   �0       (           0    0    carros_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.carros_id_seq', 50, true);
          public          postgres    false    214            )           0    0    vendalogs_logid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.vendalogs_logid_seq', 1, true);
          public          postgres    false    220            *           0    0    vendas_vendaid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.vendas_vendaid_seq', 6, true);
          public          postgres    false    218            +           0    0    vendedores_vendedorid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.vendedores_vendedorid_seq', 4, true);
          public          postgres    false    216            |           2606    24706    carros carros_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.carros
    ADD CONSTRAINT carros_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.carros DROP CONSTRAINT carros_pkey;
       public            postgres    false    215            �           2606    24745    vendalogs vendalogs_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.vendalogs
    ADD CONSTRAINT vendalogs_pkey PRIMARY KEY (logid);
 B   ALTER TABLE ONLY public.vendalogs DROP CONSTRAINT vendalogs_pkey;
       public            postgres    false    221            �           2606    24727    vendas vendas_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (vendaid);
 <   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
       public            postgres    false    219            ~           2606    24720 (   vendedores vendedores_codigonumerico_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_codigonumerico_key UNIQUE (codigonumerico);
 R   ALTER TABLE ONLY public.vendedores DROP CONSTRAINT vendedores_codigonumerico_key;
       public            postgres    false    217            �           2606    24718    vendedores vendedores_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_pkey PRIMARY KEY (vendedorid);
 D   ALTER TABLE ONLY public.vendedores DROP CONSTRAINT vendedores_pkey;
       public            postgres    false    217            �           2620    24747    vendas vendalogtrigger    TRIGGER     n   CREATE TRIGGER vendalogtrigger AFTER INSERT ON public.vendas FOR EACH ROW EXECUTE FUNCTION public.logvenda();
 /   DROP TRIGGER vendalogtrigger ON public.vendas;
       public          postgres    false    219    222            �           2606    24728    vendas vendas_carroid_fkey    FK CONSTRAINT     z   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_carroid_fkey FOREIGN KEY (carroid) REFERENCES public.carros(id);
 D   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_carroid_fkey;
       public          postgres    false    3196    219    215            �           2606    24733 !   vendas vendas_vendedorcodigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_vendedorcodigo_fkey FOREIGN KEY (vendedorcodigo) REFERENCES public.vendedores(codigonumerico);
 K   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_vendedorcodigo_fkey;
       public          postgres    false    217    3198    219               T  x�m�[S�0����ƺ��<PZHK	Cy�H4�b��/mɯ��+;��<d&�J:{Χu<��j(\��R�Yi�_�qw���I�?F�]������u)$�XgZ�_	�r�οm��/�!����ց�:	ū��O5-uw0}q�
ŏ�~7���
]����/��/�m�C��Е Pj���j��U[k�;�U�����eE)|�M�+ؘ��+G;����X߾�8:{���kSz��0���<�����x<�H�u;+Ag2�m�Uc�6���Lsva��������h�{S�l��]����ѠH��;ӽ��L�����)S��peu��őX%Zi?�1��|�ΐKy<73��6ݳ�;�����ASK�I�S������Ae:�R`Qk�6ݳm^-�za�^��<}G�U�/IP�<,���T�@�2+�)�w�8�g�J��#��<$��I�(���R�CpN��*�ҍ����N��'F��\ �� �<g'M�\H�~�]>�xf;����Ϣ�O|�'��N�t�-��qx"�k�lI�@B�%6$�Y���n��;_�6
>��c7MK ���	�@@��3v�'DSD�)�ߺ�O�n�?�+�&�n��
ɪYh��'���m��ni�l1�i�t���YQ�����N���Fb�m�*r:;������ݾ�GA��,ᘋ���^��r:	|,]������Z��I�U�_V1��ۂDr>O���Gn����hI�т�	�Q�	��`�)��*���?}mZɡ4��jj�f�`=^��d�ـ��c�v�x��t�Gh�@��<%D��x
��ePo?�����yE� ��         8   x���  ��Ta���P��סf>��l�Ś��H��@�n�x.��#Dt��	F         H   x�M̱�@��ޅ�i���i�8AP��tE*�4��k�V�*�l�Z_��p0�o������އ��j�         Q   x�3�tN,��/V��)K�4400�2��M,�LT�/�qsz�^�����Y��Y5�2�t�KTH-�	�p��qqq !�q     
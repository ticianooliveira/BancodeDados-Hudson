PGDMP         5                |            Vendas    15.4    15.4 .    2           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            3           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            4           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            5           1262    24909    Vendas    DATABASE        CREATE DATABASE "Vendas" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "Vendas";
                postgres    false            �            1259    24919    clientes    TABLE     �   CREATE TABLE public.clientes (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    cpf character varying(14) NOT NULL,
    email character varying(100),
    telefone character varying(15)
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    24928 	   enderecos    TABLE     �   CREATE TABLE public.enderecos (
    id integer NOT NULL,
    cliente_id integer,
    cidade character varying(100) NOT NULL,
    endereco character varying(255) NOT NULL
);
    DROP TABLE public.enderecos;
       public         heap    postgres    false            �            1259    24940    vendas    TABLE     �   CREATE TABLE public.vendas (
    id integer NOT NULL,
    cliente_id integer,
    data_venda date NOT NULL,
    valor_total numeric(10,2) NOT NULL
);
    DROP TABLE public.vendas;
       public         heap    postgres    false            �            1259    24972    cidade_mais_vendas_2023    VIEW     �  CREATE VIEW public.cidade_mais_vendas_2023 AS
 SELECT e.cidade,
    count(v.id) AS quantidade_total_vendas,
    sum(v.valor_total) AS valor_total_vendas
   FROM ((public.vendas v
     JOIN public.clientes c ON ((v.cliente_id = c.id)))
     JOIN public.enderecos e ON ((c.id = e.cliente_id)))
  WHERE (EXTRACT(year FROM v.data_venda) = (2023)::numeric)
  GROUP BY e.cidade
  ORDER BY (count(v.id)) DESC, (sum(v.valor_total)) DESC
 LIMIT 1;
 *   DROP VIEW public.cidade_mais_vendas_2023;
       public          postgres    false    217    221    221    221    221    219    219            �            1259    24918    clientes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.clientes_id_seq;
       public          postgres    false    217            6           0    0    clientes_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;
          public          postgres    false    216            �            1259    24927    enderecos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.enderecos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.enderecos_id_seq;
       public          postgres    false    219            7           0    0    enderecos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.enderecos_id_seq OWNED BY public.enderecos.id;
          public          postgres    false    218            �            1259    24952    itens_venda    TABLE     �   CREATE TABLE public.itens_venda (
    id integer NOT NULL,
    venda_id integer,
    produto_id integer,
    quantidade integer NOT NULL,
    valor_total numeric(10,2) NOT NULL
);
    DROP TABLE public.itens_venda;
       public         heap    postgres    false            �            1259    24951    itens_venda_id_seq    SEQUENCE     �   CREATE SEQUENCE public.itens_venda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.itens_venda_id_seq;
       public          postgres    false    223            8           0    0    itens_venda_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.itens_venda_id_seq OWNED BY public.itens_venda.id;
          public          postgres    false    222            �            1259    24912    produtos    TABLE     �   CREATE TABLE public.produtos (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    preco numeric(10,2) NOT NULL
);
    DROP TABLE public.produtos;
       public         heap    postgres    false            �            1259    24911    produtos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produtos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.produtos_id_seq;
       public          postgres    false    215            9           0    0    produtos_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.produtos_id_seq OWNED BY public.produtos.id;
          public          postgres    false    214            �            1259    24939    vendas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.vendas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.vendas_id_seq;
       public          postgres    false    221            :           0    0    vendas_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.vendas_id_seq OWNED BY public.vendas.id;
          public          postgres    false    220            �            1259    24968    vendas_produtos_view    VIEW       CREATE VIEW public.vendas_produtos_view AS
 SELECT p.nome AS nome_produto,
    iv.quantidade,
    iv.valor_total,
    v.id AS venda_id
   FROM ((public.itens_venda iv
     JOIN public.produtos p ON ((iv.produto_id = p.id)))
     JOIN public.vendas v ON ((iv.venda_id = v.id)));
 '   DROP VIEW public.vendas_produtos_view;
       public          postgres    false    215    221    223    223    215    223    223            �           2604    24922    clientes id    DEFAULT     j   ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);
 :   ALTER TABLE public.clientes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    24931    enderecos id    DEFAULT     l   ALTER TABLE ONLY public.enderecos ALTER COLUMN id SET DEFAULT nextval('public.enderecos_id_seq'::regclass);
 ;   ALTER TABLE public.enderecos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            �           2604    24955    itens_venda id    DEFAULT     p   ALTER TABLE ONLY public.itens_venda ALTER COLUMN id SET DEFAULT nextval('public.itens_venda_id_seq'::regclass);
 =   ALTER TABLE public.itens_venda ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    24915    produtos id    DEFAULT     j   ALTER TABLE ONLY public.produtos ALTER COLUMN id SET DEFAULT nextval('public.produtos_id_seq'::regclass);
 :   ALTER TABLE public.produtos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    24943 	   vendas id    DEFAULT     f   ALTER TABLE ONLY public.vendas ALTER COLUMN id SET DEFAULT nextval('public.vendas_id_seq'::regclass);
 8   ALTER TABLE public.vendas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            )          0    24919    clientes 
   TABLE DATA           B   COPY public.clientes (id, nome, cpf, email, telefone) FROM stdin;
    public          postgres    false    217   �4       +          0    24928 	   enderecos 
   TABLE DATA           E   COPY public.enderecos (id, cliente_id, cidade, endereco) FROM stdin;
    public          postgres    false    219   �6       /          0    24952    itens_venda 
   TABLE DATA           X   COPY public.itens_venda (id, venda_id, produto_id, quantidade, valor_total) FROM stdin;
    public          postgres    false    223   �7       '          0    24912    produtos 
   TABLE DATA           3   COPY public.produtos (id, nome, preco) FROM stdin;
    public          postgres    false    215   �8       -          0    24940    vendas 
   TABLE DATA           I   COPY public.vendas (id, cliente_id, data_venda, valor_total) FROM stdin;
    public          postgres    false    221   �9       ;           0    0    clientes_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.clientes_id_seq', 15, true);
          public          postgres    false    216            <           0    0    enderecos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.enderecos_id_seq', 15, true);
          public          postgres    false    218            =           0    0    itens_venda_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.itens_venda_id_seq', 28, true);
          public          postgres    false    222            >           0    0    produtos_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.produtos_id_seq', 20, true);
          public          postgres    false    214            ?           0    0    vendas_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.vendas_id_seq', 15, true);
          public          postgres    false    220            �           2606    24926    clientes clientes_cpf_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_cpf_key UNIQUE (cpf);
 C   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_cpf_key;
       public            postgres    false    217            �           2606    24924    clientes clientes_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    217            �           2606    24933    enderecos enderecos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT enderecos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.enderecos DROP CONSTRAINT enderecos_pkey;
       public            postgres    false    219            �           2606    24957    itens_venda itens_venda_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.itens_venda
    ADD CONSTRAINT itens_venda_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.itens_venda DROP CONSTRAINT itens_venda_pkey;
       public            postgres    false    223            �           2606    24917    produtos produtos_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.produtos DROP CONSTRAINT produtos_pkey;
       public            postgres    false    215            �           2606    24945    vendas vendas_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
       public            postgres    false    221            �           2606    24934 #   enderecos enderecos_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.enderecos
    ADD CONSTRAINT enderecos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);
 M   ALTER TABLE ONLY public.enderecos DROP CONSTRAINT enderecos_cliente_id_fkey;
       public          postgres    false    3211    219    217            �           2606    24963 '   itens_venda itens_venda_produto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.itens_venda
    ADD CONSTRAINT itens_venda_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produtos(id);
 Q   ALTER TABLE ONLY public.itens_venda DROP CONSTRAINT itens_venda_produto_id_fkey;
       public          postgres    false    3207    223    215            �           2606    24958 %   itens_venda itens_venda_venda_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.itens_venda
    ADD CONSTRAINT itens_venda_venda_id_fkey FOREIGN KEY (venda_id) REFERENCES public.vendas(id);
 O   ALTER TABLE ONLY public.itens_venda DROP CONSTRAINT itens_venda_venda_id_fkey;
       public          postgres    false    3215    221    223            �           2606    24946    vendas vendas_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);
 G   ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_cliente_id_fkey;
       public          postgres    false    221    217    3211            )   �  x�e�Mn�0��ϧ����])HTD��<��FN��*�ӣ�b}6+'���d<��I�ؿ_�?�y �,O��J��\�)\-�7���ͨ��-H���2ء��?��D���*�$Ϥ�>��Ixc9,���rJ�Ѧ�&�Q9'	o��E����G�F���G���Jث��[bw�}<���gQ�$	o��=�V��=��$�U$�հ��´J�F����0��$��`3M��K��G�9\_aT���76��@���+�:�Njt�.���$�������6ߣ��!��He*�1)a���)�x��:�x��sH�H2dFh������m�]>�rА9���Ы9"k����N�
���m�#'�����
�+�0�%���4�����k���)e����1�sC�G      +     x�%�=N1��S�,���-�@	(���A��N��R�:�T!�ڑ��=�=ϳ`�p�z�1�G��!��C{/tt�������PY�X@s���E���܅������%��f�}F�ne6�
*X�џ�O��������!�q�;I���.�M�4p���G���2�e[ha��8��ƭ�E�t��G��7T������7x}�1�vZ��{�������q���G���ȴ�Ѱ�`KH���߫���m���V����=��7�� kk�      /   �   x�U�Q� C��0A{���96Qڱ�?�g)*�~��z�Z�;ɖML��o�P�s�&˒���<�����Xtl}#kb<�4
Y���D���+r�6c���R��8R,S��bW:����؉��Zn�	KV��f���x�Ûcƺ��6�eaϣ���yE��{����� �q�>�����J)��F�      '     x�5�Mn�@�׏Sp�h�� �$U�*mԤʦ��dT���$�uګ�b�����l�먴��b!Da�*v��5�z�ʆ�J��F;��=Hq��Q�$X��kGH�*�S{a�:�
K�ȱ��1�H<(p��R-"_K��>EXS�z���ۻI����~��EX��Zb��I;�@�>1�����x�'ؑ�Y��')��o�70d��pEM}��י�ηr��d�c���4L�;������~lx֦nh���y�{�Xu=^16?A��8kY      -   �   x�E��� �K/�i��K��#"��u�ȳ��օ���%�ZX�
86Xa�h�;��w.h	D���EG
�<1�N�9��
�b�����O3Φ��%ۡ����x(XK�K	D&�+r�,ᠿb�K쌿��q��j�}�a;�     
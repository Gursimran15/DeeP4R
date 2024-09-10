// ---------------------------------------------------------------------------
// Ingress Deparser
// ---------------------------------------------------------------------------
control IngressDeparser(packet_out pkt,
    /* User */
    inout ingress_headers_t                       hdr,
    in    ingress_metadata_t                      meta,
    /* Intrinsic */
    in    ingress_intrinsic_metadata_for_deparser_t  ig_dprsr_md)
{
        //Mirror function add it here
        Mirror() mirror;

    apply {
        // Mirror (ingress to egress) to recirculate port only for original packet - MirrorId_t
        if (ig_dprsr_md.mirror_type == MIRROR_TYPE_I2E) {
              //mirror.emit<mirror_h>((MirrorId_t)27,{pkt_type});
            mirror.emit<mirror_h>(meta.ing_mir_ses,{meta.PKT_TYPE_MIRROR}); // Working - change pkt_type
        }

        pkt.emit(hdr.ethernet);
        pkt.emit(hdr.ipv4);
        pkt.emit(hdr.ipv6);
        pkt.emit(hdr.udp);
        pkt.emit(hdr.tcp);
        pkt.emit(hdr.recir);
        pkt.emit(hdr.app);
    }
}

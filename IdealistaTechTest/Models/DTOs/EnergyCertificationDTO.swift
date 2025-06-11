struct EnergyCertificationDTO: Codable {
    let title: String
    let energyConsumption: CertificationType
    let emissions: CertificationType
}

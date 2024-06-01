using UnityEngine;

public class SphereGenerator : MonoBehaviour
{
    public int numberOfSpheres = 100; // Nombre de sphères à générer
    public float areaSize = 10f; // Taille de la zone de génération
    public float sphereRadius = 0.5f; // Rayon des sphères
    public Material sphereMaterial; // Matériau à appliquer aux sphères

    void Start()
    {
        GenerateSpheres();
    }

    void GenerateSpheres()
    {
        for (int i = 0; i < numberOfSpheres; i++)
        {
            // Génération de positions aléatoires dans la zone spécifiée
            float x = Random.Range(-areaSize / 2, areaSize / 2);
            float y = Random.Range(-areaSize / 2, areaSize / 2);
            float z = Random.Range(-areaSize / 2, areaSize / 2);

            Vector3 spherePosition = new Vector3(x, y, z);

            // Création de la sphère
            GameObject sphere = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            sphere.transform.position = spherePosition;
            sphere.transform.localScale = Vector3.one * sphereRadius * 2; // Ajustement de l'échelle pour correspondre au rayon

            // Appliquer le matériau à la sphère
            if (sphereMaterial != null)
            {
                Renderer sphereRenderer = sphere.GetComponent<Renderer>();
                sphereRenderer.material = sphereMaterial;
            }
        }
    }
}
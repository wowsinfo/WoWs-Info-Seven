
export const getTierLabel = (tier) => {
  if (tier < 1) return 'O';
  // From 1 to 15
  const label = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'XI', 'X', 'XI', 'XII', 'XIII', 'XIV', 'XV'];
  return label[tier - 1];
}
SIGSTRM12GIS             �_�                  Signkey.EditorSignature�u+�#%�i�� �ϧ��M��i�CFt-cצ�4x��.��fp�{Wv�;��K���nC������Aq+�A<����h�c�c�?<+0���k�N��|Y%ݖ]T��n*�qZ��n+|��m|��"2N�$2��-~
=�_�NJhbI�7ѧU4 %�/�8��Xξ7���?s�h����ĸR����-�2wt��@�k�5�s�'�I��%�n>�
|�U���$���M��aQ_>�C� ȃv>﻿local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

if talosProgress:IsVarSet("Randomizer_UnlockItems") then
  talosProgress:AssureUnlockedMechanic("MechanicCube")
  talosProgress:AssureUnlockedMechanic("MechanicRods")
  talosProgress:AssureUnlockedMechanic("MechanicFan")
  talosProgress:AssureUnlockedMechanic("MechanicShield")
  talosProgress:AssureUnlockedMechanic("MechanicTime")
  prjOnMechanicLockingChanged(worldInfo)
end

if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gate:AssureOpened()
endJ�p��Dvվ+��kHg>�I�3��|�x�u�sEx��i�U���� T��a<�/��ujHh]��m$w~h�^�ɸu_�����KK4��S�/-(�T#��][()�Qe��ZS�l�����v��-��֕���ʴ��M8�{��>B��j�D���D�k*�h,�w �V���"�&��j̆.�[������}�|
�_=���7�h��`�Nq�V.-y`�࠿�5�Ҹ;�Ŝ�t5�